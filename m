Received: from eggs.gnu.org ([2001:4830:134:3::10]:50966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e59o7-000334-D8
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e59o5-0006RZ-P6
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:20:15 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e59o4-0006Pf-Ac
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:20:13 -0400
Date: Thu, 19 Oct 2017 21:42:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171019104218.GB13245@umbus>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016165916.GI3246@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20171016165916.GI3246@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 02:59:16PM -0200, Eduardo Habkost wrote:
> On Mon, Oct 16, 2017 at 06:22:54PM +0200, Igor Mammedov wrote:
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/sysemu/sysemu.h |  1 +
> >  qemu-options.hx         | 15 ++++++++++++++
> >  qmp.c                   |  5 +++++
> >  vl.c                    | 54 +++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  4 files changed, 74 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index b213696..3feb94f 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -66,6 +66,7 @@ typedef enum WakeupReason {
> >      QEMU_WAKEUP_REASON_OTHER,
> >  } WakeupReason;
> > =20
> > +void qemu_exit_preconfig_request(void);
> >  void qemu_system_reset_request(ShutdownCause reason);
> >  void qemu_system_suspend_request(void);
> >  void qemu_register_suspend_notifier(Notifier *notifier);
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 39225ae..bd44db8 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3498,6 +3498,21 @@ STEXI
> >  Run the emulation in single step mode.
> >  ETEXI
> > =20
> > +DEF("paused", HAS_ARG, QEMU_OPTION_paused, \
> > +    "-paused [state=3D]postconf|preconf\n"
> > +    "                postconf: pause QEMU after machine is initialized=
\n"
> > +    "                preconf: pause QEMU before machine is initialized=
\n",
> > +    QEMU_ARCH_ALL)
>=20
> I would like to allow pausing before machine-type is selected, so
> management could run query-machines before choosing a
> machine-type.  Would that need a third "-pause" mode, or will we
> be able to change "preconf" to pause before select_machine() is
> called?
>=20
> The same probably applies to other things initialized before
> machine_run_board_init() that could be configurable using QMP,
> including but not limited to:
> * Accelerator configuration
> * Registering global properties
> * RAM size
> * SMP/CPU configuration

Yeah.. having a bunch of different possible pause stages to select
doesn't sound great.  Could we avoid this by instead changing -S to
pause at the earliest possible spot, but having any monitor commands
that require a later stage automatically "fast forwarding" to the
right phase?

>=20
>=20
> > +STEXI
> > +@item -paused
> > +@findex -paused
> > +if set enabled interactive configuration stages before machine emulati=
on starts.
> > +'postconf' option value mimics -S option behaviour where machine is cr=
eated
> > +but emulation isn't started. 'preconf' option value pauses QEMU before=
 machine
> > +is created, which allows to query and configure properties affecting m=
achine
> > +initialization. Use monitor/QMP command 'cont' to go to exit paused st=
ate.
>=20
> What if "-S" is used at the same time"?  Will "cont" only
> initialize the machine and wait for another "cont" command to
> start the VCPUs, or will it unpause everything?
>=20
>=20
> > +ETEXI
> > +
> >  DEF("S", 0, QEMU_OPTION_S, \
> >      "-S              freeze CPU at startup (use 'c' to start execution=
)\n",
> >      QEMU_ARCH_ALL)
> > diff --git a/qmp.c b/qmp.c
> > index e8c3031..49e9a5c 100644
> > --- a/qmp.c
> > +++ b/qmp.c
> > @@ -167,6 +167,11 @@ void qmp_cont(Error **errp)
> >      BlockBackend *blk;
> >      Error *local_err =3D NULL;
> > =20
> > +    if (runstate_check(RUN_STATE_PRELAUNCH)) {
> > +        qemu_exit_preconfig_request();
> > +        return;
> > +    }
> > +
> >      /* if there is a dump in background, we should wait until the dump
> >       * finished */
> >      if (dump_in_progress()) {
> > diff --git a/vl.c b/vl.c
> > index 3fed457..30631fd 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -555,6 +555,20 @@ static QemuOptsList qemu_fw_cfg_opts =3D {
> >      },
> >  };
> > =20
> > +static QemuOptsList qemu_paused_opts =3D {
> > +    .name =3D "paused",
> > +    .implied_opt_name =3D "state",
> > +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_paused_opts.head),
> > +    .desc =3D {
> > +        {
> > +            .name =3D "state",
> > +            .type =3D QEMU_OPT_STRING,
> > +            .help =3D "Pause state of QEMU on startup",
> > +        },
> > +        { /* end of list */ }
> > +    },
> > +};
> > +
> >  /**
> >   * Get machine options
> >   *
> > @@ -1689,6 +1703,11 @@ static pid_t shutdown_pid;
> >  static int powerdown_requested;
> >  static int debug_requested;
> >  static int suspend_requested;
> > +static enum {
> > +    PRECONFIG_CONT =3D 0,
> > +    PRECONFIG_PAUSE,
> > +    PRECONFIG_SKIP,
> > +} preconfig_requested;
> >  static WakeupReason wakeup_reason;
> >  static NotifierList powerdown_notifiers =3D
> >      NOTIFIER_LIST_INITIALIZER(powerdown_notifiers);
> > @@ -1773,6 +1792,11 @@ static int qemu_debug_requested(void)
> >      return r;
> >  }
> > =20
> > +void qemu_exit_preconfig_request(void)
> > +{
> > +    preconfig_requested =3D PRECONFIG_CONT;
> > +}
> > +
> >  /*
> >   * Reset the VM. Issue an event unless @reason is SHUTDOWN_CAUSE_NONE.
> >   */
> > @@ -1939,6 +1963,12 @@ static bool main_loop_should_exit(void)
> >      RunState r;
> >      ShutdownCause request;
> > =20
> > +    if (runstate_check(RUN_STATE_PRELAUNCH)) {
> > +        if (preconfig_requested =3D=3D PRECONFIG_CONT) {
> > +            preconfig_requested =3D PRECONFIG_SKIP;
> > +            return true;
> > +        }
> > +    }
> >      if (qemu_debug_requested()) {
> >          vm_stop(RUN_STATE_DEBUG);
> >      }
> > @@ -3177,6 +3207,7 @@ int main(int argc, char **argv, char **envp)
> >      qemu_add_opts(&qemu_icount_opts);
> >      qemu_add_opts(&qemu_semihosting_config_opts);
> >      qemu_add_opts(&qemu_fw_cfg_opts);
> > +    qemu_add_opts(&qemu_paused_opts);
> >      module_call_init(MODULE_INIT_OPTS);
> > =20
> >      runstate_init();
> > @@ -3845,6 +3876,26 @@ int main(int argc, char **argv, char **envp)
> >                      exit(1);
> >                  }
> >                  break;
> > +            case QEMU_OPTION_paused:
> > +                {
> > +                    const char *value;
> > +
> > +                    opts =3D qemu_opts_parse_noisily(qemu_find_opts("p=
aused"),
> > +                                                   optarg, true);
> > +                    if (opts =3D=3D NULL) {
> > +                        exit(1);
> > +                    }
> > +                    value =3D qemu_opt_get(opts, "state");
> > +                    if (!strcmp(value, "postconf")) {
> > +                        autostart =3D 0;
> > +                    } else if (!strcmp(value, "preconf")) {
> > +                        preconfig_requested =3D PRECONFIG_PAUSE;
> > +                    } else {
> > +                        error_report("incomplete '-paused' option\n");
> > +                        exit(1);
> > +                    }
> > +                    break;
> > +                }
> >              case QEMU_OPTION_enable_kvm:
> >                  olist =3D qemu_find_opts("machine");
> >                  qemu_opts_parse_noisily(olist, "accel=3Dkvm", false);
> > @@ -4731,7 +4782,6 @@ int main(int argc, char **argv, char **envp)
> >      current_machine->boot_order =3D boot_order;
> >      current_machine->cpu_model =3D cpu_model;
> > =20
> > -
> >      /* parse features once if machine provides default cpu_type */
> >      if (machine_class->default_cpu_type) {
> >          current_machine->cpu_type =3D machine_class->default_cpu_type;
> > @@ -4741,6 +4791,8 @@ int main(int argc, char **argv, char **envp)
> >          }
> >      }
> > =20
> > +    main_loop(); /* do monitor/qmp handling at preconfig state if requ=
ested */
> > +
>=20
> I'm impressed by the simplicity of the implementation.  I though
> this would involve moving everything between this line and the
> next main_loop() call outside main(), so they would be called by
> qmp_cont().
>=20
> Any expert on GLib's Event Loop sees any gotcha in this method?
>=20
> I would like to do a careful review of main_loop_wait() and
> main_loop_should_exit(), to ensure those functions don't depend
> on anything that's initialized after this line.  Probably a few
> existing QMP commands can crash if machine is not initialized
> yet?
>=20
> The rules and expectations on initialization ordering are very
> subtle, I suggest including test code for the new feature to
> ensure nothing crashes or breaks in the future.
>=20
>=20
> >      machine_run_board_init(current_machine);
> > =20
> >      realtime_init();
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnogXgACgkQbDjKyiDZ
s5JDhRAAiOAaUx4Xn+08LSNvMMPugUDn3Tq3oJaF6CLq84catw/OLOK+AoIl1jCV
uM36PWA/9h+xJ/LOa4IPN2u7zxnz7HSWOqt/rQ9sm4WdODssePjMqItGl1tPNa29
px1mKvaXiSQuh9e8tJ5rCooI9qaGInxJ+JP3ZMZpwK4KQQI0CTTcpE2OaqE2d5bA
OTB+EN7D+qXWuHuFP6//qrcfeFAsnGJTjWeO1oQu17F1z999a2Vd2iRsb+Dymy0R
5cemK01cmSiAZXyP0upLN8frolCFvd+T/PXgHATBSTw0j19AVv60hDwkWJuomhW9
KbV9HyyNcxvqBb359mlwOXxangZwZizfl1UCt1lGTiLqlVFSG/fMezuy3bVNS6mH
jZL/2Q+PEM4XCkjL9UgANjWn0CjKm+o1hqkXHSFRYoUNwJJeOXuBB33twroL5e37
sVHDYitOxXeSSdIJZVScX8xOGRtE5HhV3qBXPQ6Bqu2PfEzqv0Z5jCcobu3HvWYp
QoLH3C9b40yVZlM+gH5YhOhgPJyh6fV8o2Rjjg0E/5pvhU9xoaGfjIOqTp681vZY
Rei4II2Sd7ZnzrSEFXPCouG0fl+f9T5AnK6NzGFDtCcM293jSbnhEoYvwFMSzxJa
HS8kVFVdUhVLaJIlwOQwtH3GRO9cfsusUM3DPauSZvEf/88jauQ=
=HvZO
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
