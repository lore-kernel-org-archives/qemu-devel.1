Received: from eggs.gnu.org ([2001:4830:134:3::10]:51452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fxxKU-00011u-4k
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fxxKP-0004en-W3
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:40:26 -0400
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
	<5c204531-2e59-4166-0325-745e4aa98531@redhat.com>
	<CAFEAcA-Auwy1Mp=L89VYB4xoCG1BFdCWyUjhA4HHFiGmycBjzg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c2d69fb0-fc47-e145-3b24-c7eb6c9cea45@redhat.com>
Date: Thu, 6 Sep 2018 18:40:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Auwy1Mp=L89VYB4xoCG1BFdCWyUjhA4HHFiGmycBjzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] scsi: remove lsi53c895a_create() and
 lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 2018-09-06 16:50, Peter Maydell wrote:
> On 6 September 2018 at 13:02, Thomas Huth <thuth@redhat.com> wrote:
>> I somehow fail to see that something outside of lsi53c895a.c should
>> really need to access the internals of LSIState. If there is something
>> that needs to be configured from the outside, it should be done via QO=
M
>> properties instead, shouldn't it? So I think I'd rather prefer if you
>> could do it the other way round and change the lsi*_create() functions
>> to return a pointer to PCIDevice instead, if possible.
>=20
> Nothing typically does, but the "modern" style of having QOM objects wh=
ich
> use other QOM objects do so by embedding the child object's struct into
> the struct of the parent requires that the struct definition is availab=
le.

But in this case we don't have anything that "inherits" from LSIState,
so shouldn't we rather follow the "information hiding" principle and
keep the state local to the lsi53c895a.c file? If you want to use a
"LSIState *" from another .c file, you can still put an "anonymous"

 struct LSIState;
 typedef struct LSIState LSIState;

in a header somewhere without revealing the implementation.

I'm fine with putting the whole LSIState into a header file if we really
need it, but in this case, I don't see the point.

 Thomas
