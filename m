Received: from eggs.gnu.org ([2001:4830:134:3::10]:56685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3jxy-0002g9-4Z
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3jxu-00027C-DC
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d3jxu-00026r-6k
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:00:14 -0400
Date: Thu, 27 Apr 2017 16:00:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170427140006.GE4805@noname.str.redhat.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
	<20170421091632.30900-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421091632.30900-3-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] memory: add support getting and using
 a dirty bitmap copy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Am 21.04.2017 um 11:16 hat Gerd Hoffmann geschrieben:
> +bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
> +                                            ram_addr_t start,
> +                                            ram_addr_t length)
> +{
> +    unsigned long page, end;
> +
> +    assert(start >= snap->start);
> +    assert(start + length <= snap->end);

Not sure if this has been reported somewhere else, but I got an
assertion failure here while booting a guest:

$ ~/source/qemu/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 2G -drive file=Windows-10-20170427.0-x86_64.qcow2,snapshot=on -usbdevice tablet -vga qxl
qemu-system-x86_64: /home/kwolf/source/qemu/exec.c:1125: cpu_physical_memory_snapshot_get_dirty: Zusicherung >>start + length <= snap->end<< nicht erf?llt.
Abgebrochen (Speicherabzug geschrieben)

Unfortunately, I didn't have gdb attached or core dumps enabled, and it
doesn't seem to reproduce easily, so I don't have anything that could
help debugging it, but I thought I'd just let you know anyway.

Kevin
