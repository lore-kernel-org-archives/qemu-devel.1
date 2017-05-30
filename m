Received: from eggs.gnu.org ([2001:4830:134:3::10]:55869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dFmd1-0005ud-Un
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dFmd1-0007qH-0T
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:27 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:33141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dFmd0-0007qB-Qv
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:26 -0400
Received: by mail-oi0-x22d.google.com with SMTP id w10so124156793oif.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 12:16:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dcee001b-755c-1a88-234b-0ca663958584@redhat.com>
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<20170526023213.18741-2-haozhong.zhang@intel.com>
	<CAJ+F1C+9o_vv4m7q47gPiaUjmQy7ag_J5ZKaHA9oagxZG2Q5Cg@mail.gmail.com>
	<20170526065132.ayapfebbft5lyigd@hz-desktop>
	<CAJ+F1CLDp7O93TRh2XcGQXXM_ZESiku0jDkcgzYUWAkP01wG9g@mail.gmail.com>
	<20170526071654.kxcqflvpo2tvcrvu@hz-desktop>
	<CAPcyv4hbf0RrjK5t5eN2Cs271JJUEYuiDNZqvso8g7QG4m4hDw@mail.gmail.com>
	<dcee001b-755c-1a88-234b-0ca663958584@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 May 2017 12:16:25 -0700
Message-ID: <CAPcyv4gA5odW2mm0_ogc1tpj2UsjGFRoE2AoiSRZjKxBAyL87g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RESEND PATCH 2/2] hostmem-file: add an attribute
 'align' to set its alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, May 30, 2017 at 5:17 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 26/05/2017 16:24, Dan Williams wrote:
>>> For DAX device only, QEMU can figure out the proper alignment by
>>> itself. However, I'm not sure whether there are other non-DAX cases
>>> requiring non-default alignment, so I think it's better to just add an
>>> interface (i.e. align attribute) in QEMU and let other management
>>> tools (e.g. libvirt?) fill a proper value.
>> I can't imagine any cases where you would want to specify an
>> alignment. If it's regular file mmap any alignment is fine, and if
>> it's device-dax only the configured alignment of the device instance
>> is allowed. So, I don't think this should be a configurable option,
>> just read it from the device instance and you're done.
>
> A 2M or 1G alignment lets KVM use EPT hugepages if the host physical
> addresses are contiguous and 2M- or 1G-aligned.
>
> QEMU only does this for hugetlbfs currently, where the requirement on
> the host physical addresses is always satisfied.  Would the same apply
> to NVDIMM device DAX?
>

Yes, I believe it is similar. Device-dax guarantees and enforces (mmap
area must be aligned) a given fault granularity.
