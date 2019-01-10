Received: from eggs.gnu.org ([209.51.188.92]:37778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghUik-0006x6-6W
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghUij-00081b-Ds
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:25:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghUij-0007vA-7R
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:25:41 -0500
Date: Thu, 10 Jan 2019 08:25:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190110072536.d5da6zqos7euz3sa@sirius.home.kraxel.org>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<26b300d6c17e6ac015f1519d50151744cf806c03.1545598229.git.DirtY.iCE.hu@gmail.com>
	<87sgy4k3u7.fsf@dusky.pond.sub.org>
	<b050b973-e675-8114-fd8a-1878dbdb81d6@gmail.com>
	<87va2zg6hh.fsf@dusky.pond.sub.org>
	<6619c58a-3e5a-a302-9bf0-acac6f7870e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6619c58a-3e5a-a302-9bf0-acac6f7870e9@gmail.com>
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
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

  Hi,

> I was thinking about creating an Audiodev (the qapi type) directly would
> be better, then somehow print it with reflection.  While this is not a
> typical use of qapi, at least qmp_qom_list creates qapi objects
> directly, so I assume it's ok.

Yes, it's perfectly fine.

> The second problem: with my patched options visitor, nested structs were
> required in qapi, the options visitor unconditionally filled them.  With
> qobject_input_visitor, I have to mark them optional, otherwise the user
> have to specify at least one option from the nested structs.

Can we just drop the nesting?

Have a look at DisplayOptions (qapi struct used to store -display
options).  It's a union, has some common base fields, and the
discriminator field (type in that case) decides which of the data
branches is used.  And on the command line I can do stuff like this:

  -display gtk,full-screen=on,zoom-to-fit=on
                              ^^^^^^^^^^^     in struct DisplayGTK
               ^^^^^^^^^^^                    common base field

Audiodev should be able to do the same to support backend-specific
options without nesting.

cheers,
  Gerd
