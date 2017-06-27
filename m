Received: from eggs.gnu.org ([2001:4830:134:3::10]:45398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dPlvP-0001Hw-TL
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dPlvP-0001Xu-1y
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:32:43 -0400
Date: Tue, 27 Jun 2017 10:32:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170627103234.28631eec@nial.brq.redhat.com>
In-Reply-To: <20170627023348.GU12152@localhost.localdomain>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
	<87a84uyj2q.fsf@linaro.org>
	<20170627023348.GU12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] cpu: Implement
 cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Mon, 26 Jun 2017 23:33:48 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Jun 26, 2017 at 02:28:13PM +0100, Alex Benn=C3=A9e wrote:
> >=20
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >  =20
> > > This patchset adds a new function cpu_generic_new()
> > > which is similar to cpu_generic_init() except that it
> > > does not realize the created CPU object. This means that
> > > board code can do a "new cpu; set QOM properties; realize"
> > > sequence without having to do all the work of splitting
> > > the CPU model string and calling parse_features by hand. =20
> >=20
> >=20
> > Just going through my review queue and I see this needs re-basing. Is
> > there going to be another rev or was a different approach suggested? =20
>=20
> The right way to go is not clear.  We know we want to remove duplication
> of CPU creation code, but probably we should first refactor the -cpu
> parsing code, so parsing happens: 1) only once; 2) earlier in main(),
> preferably before machine->init() runs; 3) inside generic code instead
> of arch-specific code; 4) preferably using the QemuOpts parser instead
> of the current strtok()-based custom parsers.
>=20
> After the parsing code mess is sorted out, writing a generic CPU
> creation wrapper will probably be easier (and safer).

Also there is legacy cpu features parsing/handling in sparc target,
so we might need to clean it up and convert to property based features
(as have been done for i386) before making generic cpu creation.
