Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUTBk-0005F0-CC
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUTBh-0005WU-3y
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:09:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUTBg-0005Vc-RX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:09:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394077749.28192.1229512133780284321.stgit@gimli.home>
Date: Wed, 05 Dec 2018 10:09:38 +0100
In-Reply-To: <154394077749.28192.1229512133780284321.stgit@gimli.home> (Alex
	Williamson's message of "Tue, 04 Dec 2018 09:26:17 -0700")
Message-ID: <87y394wd9p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 3/9] qapi: Define PCIe link
 speed and width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>

Alex Williamson <alex.williamson@redhat.com> writes:

> Create properties to be able to define speeds and widths for PCIe
> links.  The only tricky bit here is that our get and set callbacks
> translate from the fixed QAPI automagic enums to those we define
> in PCI code to represent the actual register segment value.

QAPI can only generate enumerations with values 0, 1, 2, ...  You want
different enumeration values, namely the actual register values.  You
still want QAPI to get its standard mapping to and from strings.

This patch's solution is to define a non-QAPI enumeration type with the
values you want [PATCH 1/9], then map between the enumerations in the
PropertyInfo methods.  Works.

You could instead use the encoding chosen by QAPI for the properties,
and map it to the register values on use.  Differently ugly.  Might be
simpler.  Your choice to make.

We could extend QAPI to permit specification of the enumeration values.
Marc-Andr=C3=A9's work to permit conditionals makes the syntax flexible
enough to support that.  Of course, adding QAPI features is worthwhile
only if we get sufficient mileage out of them to result in an overall
improvement.  Even if we decided to do it right now, I'd recommend not
to wait for it, but instead plan to simplify after the feature lands.

> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
