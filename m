Received: from eggs.gnu.org ([2001:4830:134:3::10]:49442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0Fv-00009q-QZ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0Fs-0002Q7-MK
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:52:11 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0Fs-0002Pv-CE
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:52:08 -0400
Received: by mail-wr0-x242.google.com with SMTP id y43so19885823wrd.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:52:08 -0700 (PDT)
Date: Tue, 25 Jul 2017 14:52:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725135204.GG23343@stefanha-x1.localdomain>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<20170724113422.GC2784@stefanha-x1.localdomain>
	<2c20cdf2-9e70-89ef-f323-d7ef77f70b29@openvz.org>
	<87y3rdopza.fsf@frigg.lan>
	<d5c6df93-1610-cf55-71b9-940da91a355e@openvz.org>
	<87zibtkd7m.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <87zibtkd7m.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, armbru@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 07:32:29PM +0300, Llu=EDs Vilanova wrote:
> Denis V Lunev writes:
>=20
> > On 07/24/2017 05:43 PM, Llu=EDs Vilanova wrote:
> >> Denis V Lunev writes:
> >>=20
> >>> On 07/24/2017 02:34 PM, Stefan Hajnoczi wrote:
> >>>> On Fri, Jul 21, 2017 at 05:31:47PM +0300, Vladimir Sementsov-Ogievsk=
iy wrote:
> >>>>> Current trace system have a drawback: parameters of trace functions
> >>>>> are calculated even if corresponding tracepoint is disabled. Also, =
it
> >>>>> looks like trace function are not actually inlined by compiler (at
> >>>>> least for me).
> >>>>>=20
> >>>>> Here is a fix proposal: move from function call to macros. Patch 02
> >>>>> is an example, of how to reduce extra calculations with help of
> >>>>> patch 01.
> >>>>>=20
> >>>>> Vladimir Sementsov-Ogievskiy (2):
> >>>>> trace: do not calculate arguments for disabled trace-points
> >>>>> monitor: improve tracing in handle_qmp_command
> >>>> Please use the TRACE_FOO_ENABLED macro instead of putting computation
> >>>> inside the trace event arguments.  This makes the code cleaner and
> >>>> easier to read.
> >>> At our opinion this ENABLED is compile time check while the option
> >>> could be tuned in runtime. Thus normally it would normally be
> >>> enabled while the trace is silent.
> >>> So, under load, we will have extra allocation, copying the command bu=
ffer,
> >>> freeing memory without actual trace. In order to fix that we should
> >>> do something like
> >>> if (trace_event_get_state(TRACE_HANDLE_QMP_COMMAND)) {
> >>> req_json =3D qobject_to_json(req);
> >>> trace_handle_qmp_command(mon, req_json);
> >>> QDECREF(req_json);
> >>> }
> >>> which is possible, but at our (me + Vova) opinion is ugly.
> >>> That is why we are proposing to switch to macro, which
> >>> will not require such tweaking.
> >>> Arguments will be only evaluated when necessary and we
> >>> will not have side-effects if the tracepoint is compile time
> >>> enabled and run-time disabled.
> >>> Though if the code above is acceptable, we can send the
> >>> patch with it. No problem.
> >> I completely get your point, but:
> >>=20
> >> * I'm not sure it will have much of a performance impact.
> >> * It is not obvious what's going to happen just by looking at the code=
 of the
> >> calling site.
> >>=20
> >> I prefer to minimize the use of macros, even if that makes a few trace=
 event
> >> calls to be a bit more verbose, as in your example above. Also, I quit=
e dislike
> >> the new style you propose:
> >>=20
> >> trace_handle_qmp_command(mon,
> >> qstring_get_str(req_json =3D qobject_to_json(req)));
> >> QDECREF(req_json);
> >>=20
> >>=20
> >> Cheers,
> >> Lluis
> > This is a matter of overall performance. For example I can have 500 VMs.
> > In order to manage them, f.e. tweak balloon I have to collect statistic=
s.
> > This happens 1 time/10 sec/VM. Libvirt issues the following
>=20
> > 494665@1486641285.213042:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name=
 "query-balloon"
> > 494665@1486641285.214181:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name=
 "qom-get"
> > 494665@1486641285.214792:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name=
 "query-hotpluggable-cpus"
> > 494665@1486641285.215283:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name=
 "query-cpus"
> > 494665@1486641285.216153:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name=
 "query-blockstats"
> > 494665@1486641285.216827:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name=
 "query-block"
>=20
> > We will have 300 commands in a second in all VMs. This is not that small
> > load. OK. I do think that I'll lost 2-3-5 percents of one host CPU due
> > to this allocation/free/copy. There are no measurements unfortunately.
> > At my opinion this matters.
>=20
> Sorry for beating the point, but I just want to make sure we're on the sa=
me
> page. The example above (with the state check) and the one you propose in=
 your
> patch have exactly the same performance.
>=20
> The change is then only in coding style, and I think the macros you propo=
se make
> the code harder to understand:
>=20
>   trace_handle_qmp_command(mon,
>                            qstring_get_str(req_json =3D qobject_to_json(r=
eq)));
>   QDECREF(req_json);
>=20
> If qobject_to_json() had any side-effect, it is not obvious why it would =
happen
> only when tracing of that event is dynaically enabled. IMO that's a recip=
e for
> errors.

I agree and this is why I said "cleaner and easier to read".  Side
effects in macro/function arguments are prone to bugs.

Stefan

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd00EAAoJEJykq7OBq3PIr0sH/32crHDKsMV96AbcxNO+TUMu
tBPZJcKsAsfJN/CY+uhxq0OE6xj0Rks877WSdtiGX/EMfMExDCDx7sL7Q0LEVQE7
bCn1cEjxb+Idvj3ayh82IFKrSpYkiAxTAa2caNHMnglAvzUvA6jto43CqCgJXyFh
sHSCpQjPriPv6tZ9PzgzWigfw8gC6Ei6YDNCUOi4wgEKt3Pel//W7eZ8NxTap7wq
1d14LxB/TfHeYXVa3cmtcm7n/T5ztydV4fd1tCGknMTpeL1pdPoUpwrAwtGOH14h
ydmBsu1TI4TeDpvt0rSrRscbvYuMXpkjgVDzf+bKTLhZfXc1mKgyjvz6wrvpun0=
=cwBv
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
