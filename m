Received: from eggs.gnu.org ([2001:4830:134:3::10]:50126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVme9-0001ND-ES
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 18:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVme8-0002Zb-E5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 18:31:45 -0400
Date: Fri, 14 Jul 2017 01:31:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170714012613-mutt-send-email-mst@kernel.org>
References: <1499825297-20335-1-git-send-email-gengdongjiu@huawei.com>
	<1499825297-20335-3-git-send-email-gengdongjiu@huawei.com>
	<20170713201407-mutt-send-email-mst@kernel.org>
	<660d600a-107c-e44a-7322-ae4a74bc5565@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660d600a-107c-e44a-7322-ae4a74bc5565@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] ACPI: Add APEI GHES Table
 Generation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, james.morse@arm.com, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

On Thu, Jul 13, 2017 at 09:41:03PM +0200, Laszlo Ersek wrote:
> >> +
> >> +        error_source++;
> >> +    }
> >> +
> >> +    for (i = 0; i < GHES_ACPI_HEST_NOTIFY_RESERVED; i++) {
> >> +        bios_linker_loader_add_pointer(linker,
> >> +            GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i, sizeof(uint64_t),
> >> +            GHES_ERRORS_FW_CFG_FILE, GHES_ACPI_HEST_NOTIFY_RESERVED *
> >> +            sizeof(uint64_t) + i * GHES_MAX_RAW_DATA_LENGTH);
> >> +    }
> 
> So basically all this math exists to set up the pointers that are shown
> in the diagram in the commit message. It is a bit tricky because most of
> those pointer fields (all 8-bytes wide) are individually embedded into
> their own containing structures. In the previous version of this patch
> set, I painstakingly verified the math, and pointed out wherever I
> thought updates were necessary.
> 
> I agree the math is hard to read, the code is very "dense". My
> suggestion (supporting yours) would be to calculate the fw_cfg blob
> offsets that should be patched in more fine-grained steps, possibly with
> multiple separate increments, using:
> - structure type names,
> - sizeof operators,
> - offsetof macros,
> - and possibly a separate comment for each offset increment.
> 
> Thanks,
> Laszlo

Right. That's not what rest of ACPI does though. What we do there
is one of:

1. Use GArray to gradually build up the structure.

Struct *s = acpi_data_push(table, sizeof (*s));
s->foo = bar;

2. Even simpler: use build_append_int_noprefix:

build_append_int_noprefix(table, 2, bar); /* Foo field */

this removes the need to declare Struct in a header,
just add comments to match the spec exactly.

We might gradually move more code to (2) but (1) is an
OK style too, it makes it obvious the sizes are fine.


-- 
MST
