Received: from eggs.gnu.org ([2001:4830:134:3::10]:52905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evUV0-0006oy-K9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evUUw-0005Sv-IE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:56:50 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:37682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evUUw-0005SO-8I
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:56:46 -0400
Received: by mail-lf0-x241.google.com with SMTP id y19-v6so25409244lfd.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 13:56:46 -0700 (PDT)
Date: Tue, 13 Mar 2018 06:56:37 +1000
From: Alexey G <x1917x@gmail.com>
Message-ID: <20180313065637.00005cee@gmail.com>
In-Reply-To: <20180312194406.GX3417@localhost.localdomain>
References: <cover.1520867740.git.x1917x@gmail.com>
	<4a65e8b30fe9d2a6c1c53b85ef2697f02e01d13f.1520867956.git.x1917x@gmail.com>
	<20180312194406.GX3417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 16/30] q35/xen: Add Xen platform device
 support for Q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, 12 Mar 2018 16:44:06 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

>On Tue, Mar 13, 2018 at 04:34:01AM +1000, Alexey Gerasimenko wrote:
>> Current Xen/QEMU method to control Xen Platform device on i440 is a
>> bit odd -- enabling/disabling Xen platform device actually modifies
>> the QEMU emulated machine type, namely xenfv <--> pc.
>> 
>> In order to avoid multiplying machine types, use a new way to
>> control Xen Platform device for QEMU -- "xen-platform-dev" machine
>> property (bool). To maintain backward compatibility with existing
>> Xen/QEMU setups, this is only applicable to q35 machine currently.
>> i440 emulation still uses the old method (i.e. xenfv/pc machine
>> selection) to control Xen Platform device, this may be changed later
>> to xen-platform-dev property as well.
>> 
>> This way we can use a single machine type (q35) and change just
>> xen-platform-dev value to on/off to control Xen platform device.
>> 
>> Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
>> ---  
>[...]
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 6585058c6c..cee0b92028 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>      "                dump-guest-core=on|off include guest memory in
>> a core dump (default=on)\n" "                mem-merge=on|off
>> controls memory merge support (default: on)\n" "
>> igd-passthru=on|off controls IGD GFX passthrough support
>> (default=off)\n"
>> +    "                xen-platform-dev=on|off controls Xen Platform
>> device (default=off)\n" "                aes-key-wrap=on|off
>> controls support for AES key wrapping (default=on)\n"
>> "                dea-key-wrap=on|off controls support for DEA key
>> wrapping (default=on)\n" "                suppress-vmdesc=on|off
>> disables self-describing migration (default=off)\n"  
>
>What are the obstacles preventing "-device xen-platform" from
>working?  It would be better than adding a new boolean option to
>-machine.

I guess the initial assumption was that changing the
xen_platform_device value in Xen's options may cause some additional
changes in platform configuration besides adding (or not) the Xen
Platform device, hence a completely different machine type was chosen
(xenfv).

At the moment pc,accel=xen/xenfv selection mostly governs
only the Xen Platform device presence. Also setting max_cpus to
HVM_MAX_VCPUS depends on it, but this doesn't applicable to a
'pc,accel=xen' machine for some reason.

If applying HVM_MAX_VCPUS to max_cpus is really necessary I think it's
better to set it unconditionally for all 'accel=xen' HVM machine
types inside xen_enabled() block. Right now it's missing for
pc,accel=xen and q35,accel=xen.

I'll check if supplying the Xen platform device via the '-device' option
will be ok for all usage cases.
