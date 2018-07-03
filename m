Received: from eggs.gnu.org ([2001:4830:134:3::10]:53709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMqi-0003rO-DB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMqd-0000LB-0f
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:04:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faMqc-0000Ki-RS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:04:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-15-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 17:04:04 +0200
In-Reply-To: <20180627163551.31610-15-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 27 Jun 2018
	18:35:50 +0200")
Message-ID: <878t6s8ior.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 14/15] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add #if defined(CONFIG_VNC) in generated code, and adjust the
> qmp/hmp code accordingly.
>
> query-qmp-schema no longer reports the command/events etc as
> available when disabled at compile.
>
> Commands made conditional:
>
> * query-vnc, query-vnc-servers, change-vnc-password
>
>   Before the patch, the commands for !CONFIG_VNC are stubs that fail
>   like this:
>
>     {"error": {"class": "GenericError",
>                "desc": "The feature 'vnc' is not enabled"}}
>
>   Afterwards, they fail like this:
>
>     {"error": {"class": "CommandNotFound",
>                "desc": "The command FOO has not been found"}}
>
>   I call that an improvement, because it lets clients distinguish
>   between command unavailable (class CommandNotFound) and command failed
>   (class GenericError).
>
> Events made conditional:
>
> * VNC_CONNECTED, VNC_INITIALIZED, VNC_DISCONNECTED
>
> HMP change:
>
> * info vnc
>
>   Will return "unknown command: 'info vnc'" when VNC is compiled
>   out (same as error for spice when --disable-spice)
>
> Occurrences of VNC (case insensitive) in the schema that aren't
> covered by this change:
>
> * add_client
>
>   Command has other uses, including "socket bases character devices".
>   These are unconditional as far as I can tell.
>
> * set_password, expire_password
>
>   In theory, these commands could be used for managing any service's
>   password.  In practice, they're used for VNC and SPICE services.
>   They're documented for "remote display session" / "remote display
>   server".
>
>   The service is selected by argument @protocol.  The code special-cases
>   protocol-specific argument checking, then calls a protocol-specific
>   function to do the work.  If it fails, the command fails with "Could
>   not set password".  It does when the service isn't compiled in (it's a
>   stub then).
>
>   We could make these commands conditional on the conjunction of all
>   services [currently: defined(CONFIG_VNC) || defined(CONFIG_SPICE)],
>   but I doubt it's worthwhile.
>
> * change
>
>   Command has other uses, namely changing media.
>   This patch inlines a stub; no functional change.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
