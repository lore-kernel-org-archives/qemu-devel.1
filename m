Received: from eggs.gnu.org ([2001:4830:134:3::10]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctxFj-0006um-KD
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctxFf-0005aT-DR
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:10:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctxFf-0005Yq-3u
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:10:07 -0400
References: <1490968309-13672-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2b71d89-8741-48f6-dea1-8bed1ebc1f21@redhat.com>
Date: Fri, 31 Mar 2017 09:10:03 -0500
MIME-Version: 1.0
In-Reply-To: <1490968309-13672-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6UTnPe5mgsd4qJD2IejVSLw2tDhMErdnT"
Subject: Re: [Qemu-devel] [PATCH] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6UTnPe5mgsd4qJD2IejVSLw2tDhMErdnT
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org
Message-ID: <d2b71d89-8741-48f6-dea1-8bed1ebc1f21@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] main_loop: Make main_loop_wait() return void
References: <1490968309-13672-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490968309-13672-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 08:51 AM, Peter Maydell wrote:
> In commit e330c118f2a5a the last usage of main_loop_wait() that cared
> about the return value was changed to no longer use it. Drop the
> now-useless return value and make the function return void.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Coverity complains (CID 1372464) about main_loop() calling
> main_loop_wait() and ignoring its return value. I suspect
> this change will just displace that to within main_loop_wait()
> itself since the underlying issue there is "the ppoll() that
> gets called to poll fds can return an error code, but what
> do we do if it does?". Suggestions on that point welcome.

At one point, there was a suggestion to introduce an ignore_value()
macro that ignores values that the compiler/coverity would otherwise
complain about, in contexts where we really are okay ignoring the value.
 If making main_loop_wait() return void shifts where Coverity blames,
then ignore_value(ppoll()) seems like it might help.

>=20
> I guess this will make the compiler warn about ret being
> set and never used if CONFIG_SLIRP is not defined, which
> is irritating. I'm postponing messing about with fixing
> that in favour of seeing whether anybody has a good answer
> to the question above (which might make it moot).
> ---

> -int main_loop_wait(int nonblocking)
> +void main_loop_wait(int nonblocking)
>  {
>      int ret;
>      uint32_t timeout =3D UINT32_MAX;
> @@ -513,7 +513,7 @@ int main_loop_wait(int nonblocking)
>      qemu_start_warp_timer();
>      qemu_clock_run_all_timers();
> =20
> -    return ret;
> +    return;
>  }

We generally avoid lone return; at the end of a void function.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6UTnPe5mgsd4qJD2IejVSLw2tDhMErdnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3mM7AAoJEKeha0olJ0NqC6YIAI4AQiKCSss+a1hIjo494mQs
gHntZIHm6OLlXFxQZSvbCM624VngxPdAQeoccv/SyZ6pPtjf33oSh0h6Z9SLB1ux
OBL/6zIRNpbQF3lh9MdcDHawiXUHJXQg4qgoNdE4UYboGjhIhS737g2eTIZsJjWI
iz9YUK9I4SQl96hXn22HhUyHuOWev+x3S0wLstPSBt7dL7katSggt4e8/LGVpSB/
c66zrgcvNCMy/w2jlRswJ3yoHESm6oX+V4Q2gQb07wIqmCgId1J/lgJnvyNYtmPE
wNFdO1TBtkOlVFeLOr80F0XoLqNQ1NsAx6pKlcL/pA/XCTgfacBa/Crp8tG9gmM=
=fs39
-----END PGP SIGNATURE-----

--6UTnPe5mgsd4qJD2IejVSLw2tDhMErdnT--
