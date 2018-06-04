Received: from eggs.gnu.org ([2001:4830:134:3::10]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fPqMq-0000n9-Bd
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fPqMo-0000gG-M3
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:21:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fPqMo-0000fu-Fq
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:21:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E293A808255C
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 14:21:49 +0000 (UTC)
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-2-berrange@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <2604e5d5-0e56-62e7-91eb-fd207a907ac8@redhat.com>
Date: Mon, 4 Jun 2018 16:21:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180604120345.12955-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vl: don't use RUN_STATE_PRECONFIG
 as initial state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On 06/04/2018 02:03 PM, Daniel P. Berrang=C3=A9 wrote:
> The RUN_STATE_PRECONFIG state is not supposed to be reachable unless th=
e
> --preconfig argument is given to QEMU, but when it was introduced in:
>=20
>   commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
>   Author: Igor Mammedov <imammedo@redhat.com>
>   Date:   Fri May 11 19:24:43 2018 +0200
>=20
>     cli: add --preconfig option
>=20
> ...the global 'current_run_state' variable was changed to have an initi=
al
> value of RUN_STATE_PRECONFIG regardless of whether --preconfig is given=
.
>=20
> A second invokation of main_loop() was added which then toggles it back
> to RUN_STATE_PRELAUNCH when --preconfig is not given. This is racy
> because it leaves a window where QEMU is in RUN_STATE_PRECONFIG despite
> --preconfig not being given. This can be seen with the failure:
>=20
>   $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
>   QEMU 2.12.50 monitor - type 'help' for more information
>   (qemu)
>   HMP not available in preconfig state, use QMP instead
>=20
> Using RUN_STATE_PRECONFIG required adding a state transition from
> RUN_STATE_PRECONFIG to RUN_STATE_INMIGRATE, which is undesirable as
> it prevented automatic detection of --preconfig & --incoming being
> mutually exclusive.
>=20
> If we use RUN_STATE_PRELAUNCH as the initial value, however, we need to
> allow transitions between RUN_STATE_PRECONFIG & RUN_STATE_PRELAUNCH in
> both directions which is also undesirable, as RUN_STATE_PRECONFIG shoul=
d
> be a one-time-only state that can never be returned to.
>=20
> This change solves the confusion by introducing a further RUN_STATE_NON=
E
> which is used as the initial state value. This can transition to any of
> RUN_STATE_PRELAUNCH, RUN_STATE_PRECONFIG or RUN_STATE_INMIGRATE. This
> avoids the need to allow any undesirable state transitions.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/run-state.json |  6 +++++-
>  vl.c                | 42 ++++++++++++++++++++++++------------------
>  2 files changed, 29 insertions(+), 19 deletions(-)
>=20
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 332e44897b..c3bd7b9b7a 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -10,6 +10,10 @@
>  #
>  # An enumeration of VM run states.
>  #
> +# @none: QEMU is in early startup. This state should never be visible
> +# when querying state from the monitor, as QEMU will have already
> +# transitioned to another state. (Since 3.0)
> +#
>  # @debug: QEMU is running on a debugger
>  #
>  # @finish-migrate: guest is paused to finish the migration process
> @@ -54,7 +58,7 @@
>  #             (Since 3.0)
>  ##
>  { 'enum': 'RunState',
> -  'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'pause=
d',
> +  'data': [ 'none', 'debug', 'inmigrate', 'internal-error', 'io-error'=
, 'paused',
>              'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm'=
,
>              'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
>              'guest-panicked', 'colo', 'preconfig' ] }
> diff --git a/vl.c b/vl.c
> index 06031715ac..30d0e985f0 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -561,7 +561,7 @@ static int default_driver_check(void *opaque, QemuO=
pts *opts, Error **errp)
>  /***********************************************************/
>  /* QEMU state */
> =20
> -static RunState current_run_state =3D RUN_STATE_PRECONFIG;
> +static RunState current_run_state =3D RUN_STATE_NONE;
> =20
>  /* We use RUN_STATE__MAX but any invalid value will do */
>  static RunState vmstop_requested =3D RUN_STATE__MAX;
> @@ -574,12 +574,11 @@ typedef struct {
> =20
>  static const RunStateTransition runstate_transitions_def[] =3D {
>      /*     from      ->     to      */
> +    { RUN_STATE_NONE, RUN_STATE_PRELAUNCH },
> +    { RUN_STATE_NONE, RUN_STATE_PRECONFIG },
> +    { RUN_STATE_NONE, RUN_STATE_INMIGRATE },
> +
>      { RUN_STATE_PRECONFIG, RUN_STATE_PRELAUNCH },
> -      /* Early switch to inmigrate state to allow  -incoming CLI optio=
n work
> -       * as it used to. TODO: delay actual switching to inmigrate stat=
e to
> -       * the point after machine is built and remove this hack.
> -       */
> -    { RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE },
> =20
>      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
>      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
> @@ -618,7 +617,6 @@ static const RunStateTransition runstate_transition=
s_def[] =3D {
> =20
>      { RUN_STATE_PRELAUNCH, RUN_STATE_RUNNING },
>      { RUN_STATE_PRELAUNCH, RUN_STATE_FINISH_MIGRATE },
> -    { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> =20
>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
> @@ -1522,7 +1520,7 @@ static pid_t shutdown_pid;
>  static int powerdown_requested;
>  static int debug_requested;
>  static int suspend_requested;
> -static bool preconfig_exit_requested =3D true;
> +static bool preconfig_exit_requested;
>  static WakeupReason wakeup_reason;
>  static NotifierList powerdown_notifiers =3D
>      NOTIFIER_LIST_INITIALIZER(powerdown_notifiers);
> @@ -3572,7 +3570,12 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              case QEMU_OPTION_preconfig:
> -                preconfig_exit_requested =3D false;
> +                if (!runstate_check(RUN_STATE_NONE)) {
> +                    error_report("'--preconfig' and '--incoming' optio=
ns are "
> +                                 "mutually exclusive");
> +                    exit(EXIT_FAILURE);
> +                }
> +                runstate_set(RUN_STATE_PRECONFIG);

Specifying --preconfig twice on the command line now fails with a very
cryptic message (there's no --incoming).

>                  break;
>              case QEMU_OPTION_enable_kvm:
>                  olist =3D qemu_find_opts("machine");
> @@ -3768,9 +3771,12 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              case QEMU_OPTION_incoming:
> -                if (!incoming) {
> -                    runstate_set(RUN_STATE_INMIGRATE);
> +                if (!runstate_check(RUN_STATE_NONE)) {
> +                    error_report("'--preconfig' and '--incoming' optio=
ns are "
> +                                 "mutually exclusive");
> +                    exit(EXIT_FAILURE);
>                  }
> +                runstate_set(RUN_STATE_INMIGRATE);

Same here. Specifying --incoming twice fails with cryptic message. But
one can argue that specifying --incoming twice is wrong anyway.

>                  incoming =3D optarg;
>                  break;
>              case QEMU_OPTION_only_migratable:

Michal
