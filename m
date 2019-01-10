Received: from eggs.gnu.org ([209.51.188.92]:55970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghXiO-0006Os-HA
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghXiN-0002mN-IL
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:37:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghXiN-0002m0-Ce
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:37:31 -0500
Date: Thu, 10 Jan 2019 11:37:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190110103729.ccneitzixs22mj25@sirius.home.kraxel.org>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<26b300d6c17e6ac015f1519d50151744cf806c03.1545598229.git.DirtY.iCE.hu@gmail.com>
	<87sgy4k3u7.fsf@dusky.pond.sub.org>
	<b050b973-e675-8114-fd8a-1878dbdb81d6@gmail.com>
	<87va2zg6hh.fsf@dusky.pond.sub.org>
	<6619c58a-3e5a-a302-9bf0-acac6f7870e9@gmail.com>
	<20190110072536.d5da6zqos7euz3sa@sirius.home.kraxel.org>
	<f433b8c2-1db4-0786-d335-42ba8a440dae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f433b8c2-1db4-0786-d335-42ba8a440dae@gmail.com>
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

> > Can we just drop the nesting?
> > 
> > Have a look at DisplayOptions (qapi struct used to store -display
> > options).  It's a union, has some common base fields, and the
> > discriminator field (type in that case) decides which of the data
> > branches is used.  And on the command line I can do stuff like this:
> > 
> >   -display gtk,full-screen=on,zoom-to-fit=on
> >                               ^^^^^^^^^^^     in struct DisplayGTK
> >                ^^^^^^^^^^^                    common base field
> > 
> > Audiodev should be able to do the same to support backend-specific
> > options without nesting.
> 
> I think that union thing works, the problem is with input and output
> settings, because they're common.  Currently you can write in.frequency
> and out.frequency, in and out are both AudiodevPerDirectionOptions.

Ah, right, I remember now.

> The alternative would be to flatten the whole structure and have
> in_frequency, out_frequency and everything else duplicated in Audiodev

Which might be not that bad after all.  The parser code is generated.
The audio drivers (where the settings are looked up) have separate code
paths for in and out anyway.  So a per-direction struct probably
wouldn't reduce the amout of code in the drivers.  Driver-specific
per-direction options are easier to deal with too I think (not sure we
have them though).

Property names should use dashes not underscores btw (i.e.
in-frequency).

cheers,
  Gerd
