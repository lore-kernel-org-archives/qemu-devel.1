Received: from eggs.gnu.org ([2001:4830:134:3::10]:38146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fpzyW-0005NC-Kt
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 13:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fpzyU-0007Qp-Os
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 13:52:52 -0400
MIME-Version: 1.0
References: <20180803144721.17036-1-stefanha@redhat.com>
	<20180803144721.17036-6-stefanha@redhat.com>
	<1a84a9fc-93f8-3573-c27e-bb60d9c48a7a@amsat.org>
	<20180813155622.GA18429@stefanha-x1.localdomain>
	<ba150247-7c07-b7fd-f1e8-0c07b5358999@amsat.org>
In-Reply-To: <ba150247-7c07-b7fd-f1e8-0c07b5358999@amsat.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 15 Aug 2018 18:52:36 +0100
Message-ID: <CAJSP0QX-YkpS_RMj2VtP34kBATtq+_dUM0p_y5FvjvNxZBGDPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 5/6] loader: Implement .hex
 file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, qemu-devel <qemu-devel@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <qemu.ml@steffen-goertz.de>, =?UTF-8?B?6IuP6Iiq?= <suhang16@mails.ucas.ac.cn>, Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>

On Wed, Aug 15, 2018 at 3:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> On 08/13/2018 12:56 PM, Stefan Hajnoczi wrote:
> > On Fri, Aug 10, 2018 at 02:00:44AM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> On 08/03/2018 11:47 AM, Stefan Hajnoczi wrote:
> >>> +        parser->rom_start_address =3D parser->next_address_to_write;
> >>> +        parser->current_rom_index =3D 0;
> >>> +        break;
> >>> +
> >>> +    case START_SEG_ADDR_RECORD:
> >>> +        if (line->byte_count !=3D 4 && line->address !=3D 0) {
> >>> +            return -1;
> >>> +        }
> >>> +
> >>> +        /* x86 16-bit CS:IP segmented addressing */
> >>> +        *(parser->start_addr) =3D (((line->data[0] << 8) | line->dat=
a[1]) << 4) |
> >>> +                                (line->data[2] << 8) | line->data[3]=
;
> >>
> >> Can you add a qtest for this case?
> >> For the HEX loader I understand the specs as this is the same parsing =
as
> >> the START_LINEAR_ADDR_RECORD case; so I disagree with data[0] and
> >> data[1] shifts.
> >
> > x86 real-mode CS:IP addressing means (CS << 4) + IP.  It produces 24-bi=
t
> > addresses on 80286 and later.  This is not the same as
> > START_LINEAR_ADDR_RECORD.
>
> OK!
>
> >
> > GNU bfd implements it as follows:
> >
> >   abfd->start_address +=3D (HEX4 (buf) << 4) + HEX4 (buf + 4);
>
> Hmm any idea why they use +4 ?

buf is char* and HEX4("0123") produces 0x0123.  So this line evaluates
ASCII hex input buf=3D"XXXXYYYY" to (0xXXXX << 4) + 0xYYYY.
