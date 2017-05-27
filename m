Received: from eggs.gnu.org ([2001:4830:134:3::10]:46142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dEQ9W-0005Kq-Vo
	for qemu-devel@nongnu.org; Fri, 26 May 2017 21:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dEQ9T-0004WS-SH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 21:04:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:17707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dEQ9T-0004Vy-JP
	for qemu-devel@nongnu.org; Fri, 26 May 2017 21:04:19 -0400
Date: Sat, 27 May 2017 09:04:14 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170527010414.aiv4vfopjlppxgi5@hz-desktop>
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<20170526023213.18741-2-haozhong.zhang@intel.com>
	<CAJ+F1C+9o_vv4m7q47gPiaUjmQy7ag_J5ZKaHA9oagxZG2Q5Cg@mail.gmail.com>
	<20170526065132.ayapfebbft5lyigd@hz-desktop>
	<CAJ+F1CLDp7O93TRh2XcGQXXM_ZESiku0jDkcgzYUWAkP01wG9g@mail.gmail.com>
	<20170526071654.kxcqflvpo2tvcrvu@hz-desktop>
	<CAPcyv4hbf0RrjK5t5eN2Cs271JJUEYuiDNZqvso8g7QG4m4hDw@mail.gmail.com>
	<20170526185516.GY32274@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170526185516.GY32274@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 05/26/17 15:55 -0300, Eduardo Habkost wrote:
> On Fri, May 26, 2017 at 07:24:26AM -0700, Dan Williams wrote:
> > On Fri, May 26, 2017 at 12:16 AM, Haozhong Zhang
> > <haozhong.zhang@intel.com> wrote:
> > > On 05/26/17 07:05 +0000, Marc-André Lureau wrote:
> > >> Hi
> > >>
> > >> On Fri, May 26, 2017 at 10:51 AM Haozhong Zhang <haozhong.zhang@intel.com>
> > >> wrote:
> > >>
> > >> > On 05/26/17 06:39 +0000, Marc-André Lureau wrote:
> > >> > > Hi
> > >> > >
> > >> > > On Fri, May 26, 2017 at 6:34 AM Haozhong Zhang <haozhong.zhang@intel.com
> > >> > >
> > >> > > wrote:
> > >> > >
> > >> > > > file_ram_alloc() currently maps the backend file via mmap to a virtual
> > >> > > > address aligned to the value returned by qemu_fd_getpagesize(). When a
> > >> > > > DAX device (e.g. /dev/dax0.0) is used as the backend file, its kernel
> > >> > > > mmap implementation may require an alignment larger than what
> > >> > > > qemu_fd_get_pagesize() returns (e.g. 2MB vs. 4KB), and mmap may fail.
> > >> > > >
> > >> > >
> > >> > > How is the accepted value queried? Any chance to configure it
> > >> > > automatically?
> > >> >
> > >> > Take /dev/dax0.0 for example. The value can be read from
> > >> > /sys/class/dax/dax0.0/device/dax_region/align.
> > >> >
> > >>
> > >> Should this work be left to management layer, or could qemu figure it out
> > >> by itself (using udev?)
> > >>
> > >
> > > For DAX device only, QEMU can figure out the proper alignment by
> > > itself. However, I'm not sure whether there are other non-DAX cases
> > > requiring non-default alignment, so I think it's better to just add an
> > > interface (i.e. align attribute) in QEMU and let other management
> > > tools (e.g. libvirt?) fill a proper value.
> > 
> > I can't imagine any cases where you would want to specify an
> > alignment. If it's regular file mmap any alignment is fine, and if
> > it's device-dax only the configured alignment of the device instance
> > is allowed. So, I don't think this should be a configurable option,
> > just read it from the device instance and you're done.
> 
> Agreed.
>

Ok, I'll drop this attribute and let QEMU figure out the alignment.

Thanks,
Haozhong

> BTW, there's no generic interface to ask the kernel what's the
> required mmap() alignment for a file?
> 
> -- 
> Eduardo
> 
