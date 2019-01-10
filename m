Received: from eggs.gnu.org ([209.51.188.92]:40265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1ghWpG-0000G5-2i
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1ghWpF-0007Uq-09
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:33 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1ghWpE-0007U0-OG
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:32 -0500
Received: by mail-wr1-x442.google.com with SMTP id u4so10569704wrp.3
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 01:40:31 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<26b300d6c17e6ac015f1519d50151744cf806c03.1545598229.git.DirtY.iCE.hu@gmail.com>
	<87sgy4k3u7.fsf@dusky.pond.sub.org>
	<b050b973-e675-8114-fd8a-1878dbdb81d6@gmail.com>
	<87va2zg6hh.fsf@dusky.pond.sub.org>
	<6619c58a-3e5a-a302-9bf0-acac6f7870e9@gmail.com>
	<20190110072536.d5da6zqos7euz3sa@sirius.home.kraxel.org>
Message-ID: <f433b8c2-1db4-0786-d335-42ba8a440dae@gmail.com>
Date: Thu, 10 Jan 2019 10:40:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190110072536.d5da6zqos7euz3sa@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/52] audio: -audiodev command line
 option basic implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 2019-01-10 08:25, Gerd Hoffmann wrote:
>   Hi,
> 
>> I was thinking about creating an Audiodev (the qapi type) directly would
>> be better, then somehow print it with reflection.  While this is not a
>> typical use of qapi, at least qmp_qom_list creates qapi objects
>> directly, so I assume it's ok.
> 
> Yes, it's perfectly fine.
> 
>> The second problem: with my patched options visitor, nested structs were
>> required in qapi, the options visitor unconditionally filled them.  With
>> qobject_input_visitor, I have to mark them optional, otherwise the user
>> have to specify at least one option from the nested structs.
> 
> Can we just drop the nesting?
> 
> Have a look at DisplayOptions (qapi struct used to store -display
> options).  It's a union, has some common base fields, and the
> discriminator field (type in that case) decides which of the data
> branches is used.  And on the command line I can do stuff like this:
> 
>   -display gtk,full-screen=on,zoom-to-fit=on
>                               ^^^^^^^^^^^     in struct DisplayGTK
>                ^^^^^^^^^^^                    common base field
> 
> Audiodev should be able to do the same to support backend-specific
> options without nesting.

I think that union thing works, the problem is with input and output
settings, because they're common.  Currently you can write in.frequency
and out.frequency, in and out are both AudiodevPerDirectionOptions.  The
alternative would be to flatten the whole structure and have
in_frequency, out_frequency and everything else duplicated in Audiodev

Regards,
Zoltan
