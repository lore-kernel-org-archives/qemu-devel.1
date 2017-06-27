Received: from eggs.gnu.org ([2001:4830:134:3::10]:58057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPgKE-0005MI-Gi
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPgKD-0000zi-Jr
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:33:58 -0400
Date: Mon, 26 Jun 2017 23:33:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170627023348.GU12152@localhost.localdomain>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
	<87a84uyj2q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87a84uyj2q.fsf@linaro.org>
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
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Mon, Jun 26, 2017 at 02:28:13PM +0100, Alex Benn=E9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > This patchset adds a new function cpu_generic_new()
> > which is similar to cpu_generic_init() except that it
> > does not realize the created CPU object. This means that
> > board code can do a "new cpu; set QOM properties; realize"
> > sequence without having to do all the work of splitting
> > the CPU model string and calling parse_features by hand.
>=20
>=20
> Just going through my review queue and I see this needs re-basing. Is
> there going to be another rev or was a different approach suggested?

The right way to go is not clear.  We know we want to remove duplication
of CPU creation code, but probably we should first refactor the -cpu
parsing code, so parsing happens: 1) only once; 2) earlier in main(),
preferably before machine->init() runs; 3) inside generic code instead
of arch-specific code; 4) preferably using the QemuOpts parser instead
of the current strtok()-based custom parsers.

After the parsing code mess is sorted out, writing a generic CPU
creation wrapper will probably be easier (and safer).

--=20
Eduardo
