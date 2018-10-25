Received: from eggs.gnu.org ([2001:4830:134:3::10]:46675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFmQu-00078Y-3E
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFmQt-0003Mz-08
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:40:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gFmQs-0003Mh-QW
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:40:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22DA8432D1
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 20:40:42 +0000 (UTC)
Date: Thu, 25 Oct 2018 21:40:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181025204029.GB29995@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
	<nycvar.YSQ.7.76.1810251622450.11480@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1810251622450.11480@xnncv>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/3] adlib: mark as insecure and
 deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Thu, Oct 25, 2018 at 04:26:16PM +0530, P J P wrote:
> +-- On Thu, 25 Oct 2018, Gerd Hoffmann wrote --+
> | We have a lovely, guest-triggerable buffer overflow in opl2 emulation.
> | 
> | Reproducer:
> |     outw(0xff60, 0x220);
> |     outw(0x1020, 0x220);
> |     outw(0xffb0, 0x220);
> | Result:
> |     Will overflow FM_OPL->AR_TABLE[] (see hw/audio/fmopl.[ch])
> 
> + Reported-by: Wangjunqing <wangjunqing@huawei.com>

So you have a CVE number for this ?

If so, it should be referenced in the commit message too, even if
we can't fix the problem.

> | diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> | index 97b876c..fb4a29c 100644
> | --- a/hw/audio/adlib.c
> | +++ b/hw/audio/adlib.c
> | @@ -311,6 +311,7 @@ static void adlib_class_initfn (ObjectClass *klass, void *data)
> |      set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> |      dc->desc = ADLIB_DESC;
> |      dc->props = adlib_properties;
> | +    dc->deprecation_reason = "insecure, buffer overflow in opl2 emulation";
> |  }
> |  
> |  static const TypeInfo adlib_info = {
> | diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> | index 11b870c..7951a4f 100644
> | --- a/qemu-deprecated.texi
> | +++ b/qemu-deprecated.texi
> | @@ -116,6 +116,10 @@ The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
> |  The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
> |  or ``ivshmem-doorbell`` device types.
> |  
> | +@subsection adlib (since 3.1)
> | +
> | +Has known buffer overflow.

It would be good to give a recommendation to a better choice to
replace its usage

> | +
> |  @section System emulator machines
> |  
> |  @subsection pc-0.10 and pc-0.11 (since 3.0)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
