Received: from eggs.gnu.org ([2001:4830:134:3::10]:52809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBB1-0000h7-R3
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBAy-00021I-KZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:45:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fCBAy-00020w-E1
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:45:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BBD481A88CB
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 21:45:04 +0000 (UTC)
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-4-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01e131e0-0cdb-c509-b264-6cdf63968a88@redhat.com>
Date: Fri, 27 Apr 2018 16:44:59 -0500
MIME-Version: 1.0
In-Reply-To: <1524841523-95513-4-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mYtQbecD5hcu0PlLegBFUsOEn8jZkK2XO"
Subject: Re: [Qemu-devel] [PATCH v6 03/11] cli: add --preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mYtQbecD5hcu0PlLegBFUsOEn8jZkK2XO
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com
Message-ID: <01e131e0-0cdb-c509-b264-6cdf63968a88@redhat.com>
Subject: Re: [PATCH v6 03/11] cli: add --preconfig option
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
 <1524841523-95513-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524841523-95513-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 10:05 AM, Igor Mammedov wrote:
> This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
> allowing the configuration of QEMU from QMP before the machine jumps
> into board initialization code of machine_run_board_init()
>=20
> The intent is to allow management to query machine state and additional=
ly
> configure it using previous query results within one QEMU instance
> (i.e. eliminate the need to start QEMU twice, 1st to query board specif=
ic
> parameters and 2nd for actual VM start using query results for
> additional parameters).
>=20
> The new option complements -S option and could be used with or without
> it. The difference is that -S pauses QEMU when the machine is completel=
y
> initialized with all devices wired up and ready to execute guest code
> (QEMU needs only to unpause VCPUs to let guest execute its code),
> while the "preconfig" option pauses QEMU early before board specific in=
it
> callback (machine_run_board_init) is executed and allows the configurat=
ion
> of machine parameters which will be used by board init code.
>=20
> When early introspection/configuration is done, command 'exit-preconfig=
'
> should be used to exit RUN_STATE_PRECONFIG and transition to the next
> requested state (i.e. if -S is used then QEMU will pause the second
> time when board/device initialization is completed or start guest
> execution if -S isn't provided on CLI)
>=20
> PS:
> Initially 'preconfig' is planned to be used for configuring numa
> topology depending on board specified possible cpus layout.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

> +++ b/include/qapi/qmp/dispatch.h
> @@ -23,6 +23,7 @@ typedef enum QmpCommandOptions
>      QCO_NO_OPTIONS            =3D  0x0,
>      QCO_NO_SUCCESS_RESP       =3D  (1U << 0),
>      QCO_ALLOW_OOB             =3D  (1U << 1),
> +    QCO_ALLOWED_IN_PRECONFIG  =3D  (1U << 2),
>  } QmpCommandOptions;

I'm thinking patch 3 and 5 should be swapped, at least for
bisectability.  Otherwise, you have a window where --preconfig works
from the command line, but there is nothing registering any commands as
allowed in preconfig, which either lets qemu get stuck (if you actually
check for this flag) or lets you break things during preconfig (if you
don't check for this flag, because then ANY command can be run); I'll
see which as I read further.

> +++ b/qapi/misc.json
> @@ -1209,6 +1209,28 @@
>  { 'command': 'cont' }
> =20
>  ##
> +# @exit-preconfig:
> +#
> +# Exit from "preconfig" state

[1]

> +#
> +# Since 2.13
> +#
> +# Returns: nothing
> +#
> +# Notes: Command makes QEMU exit from preconfig state and proceeds wit=
h
> +# VM initialization using configuration data provided on command line
> +# and via QMP monitor at preconfig state. Command is available only at=

> +# preconfig state (i.e. if --preconfig command line option).

Wording suggestion:

Notes: This command makes QEMU exit the preconfig state and proceed with
VM initialization using configuration data provided on the command line
and via the QMP monitor during the preconfig stat.  The command is only
available during the preconfig state (i.e. when the --preconfig command
line option was in use).

Also, I wonder if you need a separate Notes: paragraph, or if this could
be used as the overall command description at [1].

> +#
> +# Example:
> +#
> +# -> { "execute": "exit-preconfig" }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'exit-preconfig' }
> +

Missing the 'allowed-in-preconfig' tag that isn't introduced until patch
5...

> @@ -101,6 +102,13 @@ static QObject *do_qmp_dispatch(QmpCommandList *cm=
ds, QObject *request,
>          return NULL;
>      }
> =20
> +    if (runstate_check(RUN_STATE_PRECONFIG) &&
> +        !(cmd->options & QCO_ALLOWED_IN_PRECONFIG)) {
> +        error_setg(errp, "The command '%s' isn't permitted in '%s' sta=
te",
> +                   cmd->name, RunState_str(RUN_STATE_PRECONFIG));
> +        return NULL;
> +    }
> +

=2E..but you check the flag, therefore with just this patch, you can't ru=
n
exit-preconfig, and any command line using --preconfig is now hung.


> +++ b/qemu-options.hx
> @@ -3304,6 +3304,19 @@ STEXI
>  Run the emulation in single step mode.
>  ETEXI
> =20
> +DEF("preconfig", 0, QEMU_OPTION_preconfig, \
> +    "--preconfig     pause QEMU before machine is initialized\n",
> +    QEMU_ARCH_ALL)
> +STEXI
> +@item --preconfig
> +@findex --preconfig
> +Pause QEMU for interactive configuration before the machine is created=
,
> +which allows querying and configuring properties that will affect
> +machine initialization. Use the QMP command 'cont' to exit the preconf=
ig

s/cont/exit-preconfig/

> +state and move to the next state (ie. run guest if -S isn't used or
> +pause the second time if -S is used).

> +@node Managed start up options
> +@section Managed start up options
> +
> +In system mode emulation, it's possible to create VM in paused state u=
sing

s/create/create a/
s/in paused/in a paused/
s/using/using the/

> +-S command line option. In this state the machine is completely initia=
lized
> +according to command line options and ready to execute VM code but VCP=
U threads
> +are not executing any code. VM state in this paused state depends on w=
ay QEMU

s/VM/The VM/
s/on way/on the way/

> +was started. It could be in:
> +@table @asis
> +@item initial state (after reset/power on state)
> +@item with direct kernel loading initial state could be amended to exe=
cute

Run-on; I'm less sure if this is what you intended, but:
s/loading initial/loading, the initial/

> +code loaded by QEMU in VM's RAM and with incoming migration

s/VM's/the VM's/

> +@item with incoming migration, initial state will by ammended with the=
 migrated

s/ammended/amended/

> +machine state after migration completes.
> +@end table
> +
> +This paused state is typically used by users to query machine state an=
d/or
> +additionally configure machine (hotplug devices) in runtime before all=
owing

s/machine (hotplug/the machine (by hotplugging/

> +VM code to run.
> +
> +However at -S pause point it's impossible to configure options that af=
fect

s/However at -S pause point/However, at the -S pause point,/

> +initial VM creation (like: -smp/-m/-numa ...) or cold plug devices. Th=
at's
> +when -preconfig command line option should be used. It allows pausing =
QEMU

s/-preconfig/the --preconfig/

> +before the initial VM creation, in a new preconfig state, where additi=
onal
> +queries and configuration can be performed via QMP before moving on to=

> +the resulting configuration startup. In the preconfig state, QEMU only=
 allows
> +a limited set of commands over the QMP monitor, where the commands do =
not
> +depend on an initialized machine, including but not limited to:
> +@table @asis
> +@item qmp_capabilities
> +@item query-qmp-schema
> +@item query-commands
> +@item query-status
> +@item exit-preconfig
> +@end table
> +The full list of commands is in QMP schema which could be queried with=

> +query-qmp-schema, where commands supported at preconfig state have opt=
ion
> +'allowed-in-preconfig' set to true.

This sentence is not true until later in the series, but I'm fine with
documentation patches going in out-of-order to avoid churn if they are
correct by the end of the series (of course, you may be reordering
things anyways, based on my earlier comments).

But overall this is looking a lot better, with documentation explaining
the need, and the new command (rather than overloading 'cont') for
switching back to the rest of the command line behavior.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mYtQbecD5hcu0PlLegBFUsOEn8jZkK2XO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjmdsACgkQp6FrSiUn
Q2qoagf/Y8b/Qu7nhW4eXSwT9QDlCENqO0JEtuDLenmzrVUVsxJusgJ6M8OqgQ4p
aUpv7wh35KuChsCRJdQ+NakCmX/oTj8QrePTYKZGZGCfznRfmCFVXPIJBp0n06Xg
rr8SmaJ8CArwF/uj7DbRcVMwBIJu9h8RJL6DXyv6EI2ht9S16QfyIAHTnyDbPLjt
p0wqTw9RGenXX80XdTsW2jDNHqaX9Z0KfBEDSH9RS/aIuqm2BJu1g8boCRn+Xh8r
jfaiDQ9La9PsASWi4YjLK/o++nRpxPOD0a/8yq+46zLnwPUwEe67FJISXandM2iu
UHr2PhtiIXA2N6BbdhpBtgfySGw3IQ==
=gb56
-----END PGP SIGNATURE-----

--mYtQbecD5hcu0PlLegBFUsOEn8jZkK2XO--
