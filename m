Received: from eggs.gnu.org ([2001:4830:134:3::10]:39060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fp9cg-0006O1-7Q
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fp9cf-0002Pf-IX
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:58:50 -0400
MIME-Version: 1.0
References: <20180803144721.17036-1-stefanha@redhat.com>
	<20180803144721.17036-5-stefanha@redhat.com>
	<CAKmqyKOthBCQrWc_v9zhdYoBATHYfjyjkUQqx1W5mktm2b+6hw@mail.gmail.com>
In-Reply-To: <CAKmqyKOthBCQrWc_v9zhdYoBATHYfjyjkUQqx1W5mktm2b+6hw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 13 Aug 2018 10:58:36 +0100
Message-ID: <CAJSP0QU2UhO+X-XX0Rj_Cj9=NmBp4aaBNRb4GExxDq546AabXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 4/6] loader: add rom transaction API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, qemu-devel <qemu-devel@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <qemu.ml@steffen-goertz.de>, =?UTF-8?B?6IuP6Iiq?= <suhang16@mails.ucas.ac.cn>, Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>

On Wed, Aug 8, 2018 at 10:32 PM Alistair Francis <alistair23@gmail.com> wrote:
> On Fri, Aug 3, 2018 at 7:47 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > @@ -1168,6 +1172,34 @@ void rom_reset_order_override(void)
> >      fw_cfg_reset_order_override(fw_cfg);
> >  }
> >
> > +void rom_transaction_begin(void)
> > +{
> > +    Rom *rom;
> > +
> > +    /* Ignore ROMs added without the transaction API */
> > +    QTAILQ_FOREACH(rom, &roms, next) {
> > +        rom->committed = true;
>
> My only thought is that maybe this should produce a warning or error
> if a ROM isn't committed.

Not all loaders use the transaction API.  Therefore it is likely that
some pre-existing ROMs will have ->committed = false.

For example, imagine a firmware ROM is loaded by the machine type and
then -kernel is used to load a file.  The -kernel loader shouldn't
worry about the firmware ROM, which was added without the transaction
API.

If we want to be strict I'd have to audit all ROM API users and wrap
them in add rom_transaction_begin/end() even if they cannot fail.
This is why I decided to simply ignore pre-existing ROMs.

Stefan
