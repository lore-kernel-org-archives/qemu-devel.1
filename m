Received: from eggs.gnu.org ([2001:4830:134:3::10]:38027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPlez-0002XH-BA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPleu-0000Ns-7t
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:20:17 -0400
Date: Mon, 4 Jun 2018 10:20:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180604092008.GA13674@stefanha-x1.localdomain>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20180603203412.11033-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC v3] qapi: command category to stimulate
 high-level machine devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2018 at 04:34:12PM -0400, Steffen G=F6rtz wrote:
> Changes in v2:
>   - Remove stray 1
>=20
> Changes in v1:
>   - Fix coding style issues
>=20
> Add a new category "stimulate" to host commands that
> act upon high-level devices associated with machines/boards.
>=20
> This is patch is part of an effort to add support for BBC:microbit
> educational computer to QEMU.
>=20
> The microbit board, as many other microcontroller boards,
> contains typical trivial (digital) input and output options such as butto=
ns and LEDs,
> but also more sophiscated possibilities such as analog inputs and
> complex dedicated sensor ICs that are connected to the microbit machine
> by means of inter-ic bus (i2c).
> These devices interact with peripheral devices of the microcontroller
> in use, for example with the GPIO peripheral of the used NRF51.
>=20
> One aim of our efforts is to create a user interface that models the
> look and feel of the physical microbit board and lets the user interact
> with its inputs and provide feedback on its outsputs.
>=20
> For this it is necessary to transmit user inputs such as the pressing of a
> button to the machine.
> In return, when the state of an output is changed on the machine, this
> change needs to be reflected in the user interface.
>=20
> At the moment, there are only a few QMP commands that provide user input =
to the
> machine, eg. send-keys, input-button. These commands require very

QMP command names (from qapi/ui.json): send-key and input-send-event.

> high-level concepts, which are not really suitable for applications that
> microcontrollers are typically used in in.

I agree that existing commands aren't suitable.  They are tied to
QemuConsole, which makes sense for graphics + keyboard/mouse input
devices but doesn't exist for microcontrollers.

I have CCed Gerd Hoffmann, the ui/ maintainer, to see if he agrees.

> This RFC is meant to start a discussion on how to provide stimuli to
> low-complex inputs and outputs typically found in embedded
> microcontroller applications. To the best of my knowledge, there are
> currently no examples of how to provide such stimuli to either SoC
> device peripheral or machine level concepts like pushbuttons and LEDs.
>=20
> To my understanding, the following concepts/apis are needed:
> - QMP commands to send stimuli to machine level concepts like
> pushbuttons
> - Machine level devices that receive these stimuli and act as an adapter
> to manipulate the associated SoC peripheral devices

The QEMU Object Model offers "interfaces".  Many object-oriented
programming languages have similar concepts (interfaces, virtual base
classes, etc).

Interfaces could be used to connect board-specific devices with the
monitor command.  But this is an implementation detail, we first need to
agree on the API design.

> - For outputs, machine level devices are needed that observe changes in
> SoC peripherals and emit QMP events that clients can receive
>=20
> This patch adds a new qmp command "buttons-set-state" to update the
> push-down state of arbitrarily identified buttons (string identifier).

Can you list the types of devices that can consume events?

 * Pushbutton
 * GPIO input pin
 * Analog-to-digital converter
 * Temperature sensor
 * Accelerometer
 * Magnetometer
 * LED voltage decay light sensing
 * ?

And list the types of devices that can produce events?

 * LED states
 * GPIO output pin
 * Digital-to-analog converter
 * ?

Many of these inputs/outputs can be tied to an external UI.  A degree of
timing precision is required so that the UI is responsive, although
cycle-accurate timing is not what I'd expect from QMP.

Stefan

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFQRIAAoJEJykq7OBq3PIA1kH/jUiBMZgVfnCZKv5lWUpSW5n
9hGfyd5HJLO0xurOpXQamnv1xNshckWAmj3U0TdZ/MUdDn6IbG2RsX4/MSd/EnpF
JB9W39eQpc/jNunCt1da0y9DTwngDlowuhmK5HjQ365Thr+YWqgpWMJJ9hjmaFaJ
ZTQLOIbDUSrwiLY+HWjvfA9jsmFbHQ+OXt08C7Mgz8fyu49SwJ/egF6Arl+eV/Gx
fipi7dC1GfqPo5evcm/WFKXhBHfzF5nA7DlE8Hs7Y0Z/qc1Mo3I3+DiblXVzjuFN
d/6uqYvnJqVmMANos3cn0xmmkkzW1jvt2Bg+fIvCYuikbL0P6OdxT/JYXI/pRU8=
=IhHS
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
