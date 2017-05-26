Received: from eggs.gnu.org ([2001:4830:134:3::10]:58846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dEGAH-00069i-DZ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dEGAG-0003Od-AO
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:24:29 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:33295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dEGAG-0003N3-3l
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:24:28 -0400
Received: by mail-oi0-x234.google.com with SMTP id w10so14552904oif.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 07:24:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170526071654.kxcqflvpo2tvcrvu@hz-desktop>
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<20170526023213.18741-2-haozhong.zhang@intel.com>
	<CAJ+F1C+9o_vv4m7q47gPiaUjmQy7ag_J5ZKaHA9oagxZG2Q5Cg@mail.gmail.com>
	<20170526065132.ayapfebbft5lyigd@hz-desktop>
	<CAJ+F1CLDp7O93TRh2XcGQXXM_ZESiku0jDkcgzYUWAkP01wG9g@mail.gmail.com>
	<20170526071654.kxcqflvpo2tvcrvu@hz-desktop>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 May 2017 07:24:26 -0700
Message-ID: <CAPcyv4hbf0RrjK5t5eN2Cs271JJUEYuiDNZqvso8g7QG4m4hDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>

On Fri, May 26, 2017 at 12:16 AM, Haozhong Zhang
<haozhong.zhang@intel.com> wrote:
> On 05/26/17 07:05 +0000, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Fri, May 26, 2017 at 10:51 AM Haozhong Zhang <haozhong.zhang@intel.co=
m>
>> wrote:
>>
>> > On 05/26/17 06:39 +0000, Marc-Andr=C3=A9 Lureau wrote:
>> > > Hi
>> > >
>> > > On Fri, May 26, 2017 at 6:34 AM Haozhong Zhang <haozhong.zhang@intel=
.com
>> > >
>> > > wrote:
>> > >
>> > > > file_ram_alloc() currently maps the backend file via mmap to a vir=
tual
>> > > > address aligned to the value returned by qemu_fd_getpagesize(). Wh=
en a
>> > > > DAX device (e.g. /dev/dax0.0) is used as the backend file, its ker=
nel
>> > > > mmap implementation may require an alignment larger than what
>> > > > qemu_fd_get_pagesize() returns (e.g. 2MB vs. 4KB), and mmap may fa=
il.
>> > > >
>> > >
>> > > How is the accepted value queried? Any chance to configure it
>> > > automatically?
>> >
>> > Take /dev/dax0.0 for example. The value can be read from
>> > /sys/class/dax/dax0.0/device/dax_region/align.
>> >
>>
>> Should this work be left to management layer, or could qemu figure it ou=
t
>> by itself (using udev?)
>>
>
> For DAX device only, QEMU can figure out the proper alignment by
> itself. However, I'm not sure whether there are other non-DAX cases
> requiring non-default alignment, so I think it's better to just add an
> interface (i.e. align attribute) in QEMU and let other management
> tools (e.g. libvirt?) fill a proper value.

I can't imagine any cases where you would want to specify an
alignment. If it's regular file mmap any alignment is fine, and if
it's device-dax only the configured alignment of the device instance
is allowed. So, I don't think this should be a configurable option,
just read it from the device instance and you're done.
