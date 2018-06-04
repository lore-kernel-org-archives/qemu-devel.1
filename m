Received: from eggs.gnu.org ([2001:4830:134:3::10]:51934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fPxkF-0004oV-Vz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fPxkC-0003lv-Q7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:14:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fPxkC-0003l0-L0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:14:28 -0400
References: <20180602031629.3925-1-contrib@steffen-goertz.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <317e07c2-b1d8-b782-9a0b-88ece8600164@redhat.com>
Date: Mon, 4 Jun 2018 17:14:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180602031629.3925-1-contrib@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] qapi: command category to stimulate
 high-level machine devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>

On 06/01/2018 10:16 PM, Steffen G=C3=B6rtz wrote:
> From: Steffen Goertz <contrib@steffen-goertz.de>
>=20
> Add a new category "stimulate" to host commands that
> act upon high-level devices associated with machines/boards.
>=20
> This is patch is part of an effort to add support for BBC:microbit
> educational computer to QEMU.
>=20
> The microbit board, as many other microcontroller boards,
> contains typical trivial (digital) input and output options such as but=
tons and LEDs,
> but also more sophiscated possibilities such as analog inputs and

s/sophiscated/sophisticated/

> complex dedicated sensor ICs that are connected to the microbit machine
> by means of inter-ic bus (i2c).
> These devices interact with peripheral devices of the microcontroller
> in use, for example with the GPIO peripheral of the used NRF51.
>=20
> One aim of our efforts is to create a user interface that models the
> look and feel of the physical microbit board and lets the user interact
> with its inputs and provide feedback on its outsputs.

s/outsputs/outputs/

>=20
> For this it is necessary to transmit user inputs such as the pressing o=
f a
> button to the machine.
> In return, when the state of an output is changed on the machine, this
> change needs to be reflected in the user interface.
>=20
> At the moment, there are only a few QMP commands that provide user inpu=
t to the
> machine, eg. send-keys, input-button. These commands require very
> high-level concepts, which are not really suitable for applications tha=
t
> microcontrollers are typically used in in.
>=20
> This RFC is meant to start a discussion on how to provide stimuli to
> low-complex inputs and outputs typically found in embedded
> microcontroller applications. To the best of my knowledge, there are
> currently no examples of how to provide such stimuli to either SoC
> device peripheral or machine level concepts like pushbuttons and LEDs.
>=20
> To my understanding, the following concepts/apis are needed:
> - QMP commands to send stimuli to machine level concepts like
> pushbuttons
> - Machine level devices that receive these stimuli and act as an adapte=
r
> to manipulate the associated SoC peripheral devices
> - For outputs, machine level devices are needed that observe changes in
> SoC peripherals and emit QMP events that clients can receive
>=20
> This patch adds a new qmp command "buttons-set-state" to update the
> push-down state of arbitrarily identified buttons (string identifier).

An arbitrary string has the most flexibility, but also the least=20
discoverability.  Is there any way to enumerate which strings are valid,=20
and/or make the button names an enum instead of an open-coded string?

>=20
> The handler of this command is mocked to set the machines SoC gpio/irq
> lines associated with these buttons on the machine by means of object
> property aliases. This is just a mock until a proper concept/api is
> agreed upon.
>=20
> As i recently joined the QEMU community as part of GSoC, i am still a
> greenhorn to the codebase and i am really excited to discuss potential
> concepts and APIs to realize the described features.

This last paragraph...

>=20
> Based-on: <20180503090532.3113-1-joel@jms.id.au>
> Signed-off-by: Steffen Goertz <contrib@steffen-goertz.de>
> ---

...would fit better here, after the --- separator.  It is useful to=20
reviewers now, but a year from now when reading the git history (and=20
hopefully after you are a regular contributor), it won't be as relevant=20
to understanding this particular patch or your contributions in general.

At this point, I haven't yet decided if this interface addition is the=20
best way to approach things, but if we take it without a redesign, it=20
needs at least the following tweaks:

> +++ b/qapi/stimulate.json
> @@ -0,0 +1,24 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# @ButtonPress:
> +#
> +# @identifier:  Name of the button.
> +# @pushed_down: State of the button.

In QMP, we prefer naming things with dash, as in 'pushed-down'.  Or, if=20
it is easier, you could create an enum with values 'down' and 'up' and=20
use that, instead of 'bool', as the type, at which point this variable=20
might be better named as 'position' instead of 'pushed-down'.

> +#
> +##

Missing a tag of:

Since: 3.0

> +{ 'struct': 'ButtonPress',
> +  'data': {
> +    'identifier': 'str',
> +    'pushed_down': 'bool'
> +     } }
> +
> +##
> +# @buttons-set-state:
> +#
> +# @buttons: List of updated button states.
> +#
> +# Returns: nothing in case of success
> +##

Missing a Since: tag.

> +{ 'command': 'buttons-set-state',
> +  'data': { 'buttons': ['ButtonPress'] } }

Doesn't let a user set button state (presumably that's for a later=20
patch), but at least answers the question on introspecting the names of=20
which buttons have state.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
