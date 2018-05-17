Received: from eggs.gnu.org ([2001:4830:134:3::10]:44604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJIv6-0002sa-Jp
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJIv1-0003dW-U0
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:26:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJIv1-0003dK-Mr
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:26:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id x9-v6so2826638wrl.13
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 06:26:07 -0700 (PDT)
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
	<20180517124403.GJ5657@redhat.com>
	<20180517125110.lhipiezmvifrg3n6@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e0213c3-017e-c794-a222-fde38676d7c8@redhat.com>
Date: Thu, 17 May 2018 15:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180517125110.lhipiezmvifrg3n6@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On 17/05/2018 14:51, Gerd Hoffmann wrote:
>   Hi,
> 
>>> +ifeq ($(CONFIG_X11),y)
>>> +sdl.mo-objs += x_keymap.o
>>> +gtk.mo-objs += x_keymap.o
>>
>> Would this cause symbol clash if both sdl & gtk modules are loaded
>> at the same time, or have we used linker scripts to limit what symbols
>> each module exposes ?
> 
> Related: can modules depend on modules, so we could make x_keymap a
> module of its own and have both gtk and sdl depend on it?
> 
> That would also be useful when trying to modularize spice.

How hard would it be to modularize the libspice-server side?  The part
of the library that is used by QXL rendering should have much fewer
dependencies than the part that is used for keyboard, mouse, audio,
vmchannel/agent, etc.

Then you could link libspice-server-core into QEMU and libspice-server
into the modules.  Unless both have been linked together, functions such
as spice_server_add_client would fail, and so would adding most of the
SPICE_INTERFACE_* interface kinds.

Thanks,

Paolo
