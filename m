Received: from eggs.gnu.org ([2001:4830:134:3::10]:50111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fJaBf-0001x3-0I
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fJaBb-0004WF-Un
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fJaBb-0004TQ-PA
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:52:23 -0400
Date: Fri, 18 May 2018 09:52:12 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180518075212.GE3416@dnr>
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20180517124109.GJ17734@vader>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.ibm.com>, fiuczy@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org, jferlan@redhat.com


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 02:41:09PM +0200, Eduardo Otubo wrote:
>On 15/05/2018 - 19:33:48, Yi Min Zhao wrote:
>> If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
>> compiled. This would make libvirt set the corresponding capability and
>> then trigger the guest startup fails. So this patch excludes the code
>> regarding seccomp staff if CONFIG_SECCOMP is undefined.
>
>Just a sugestion for the next patch you send: If it's a single patch, you =
don't
>need to format it with a cover-letter. Just put all the description in the=
 body,
>or if you need to add a text that shouldn't be included in the commit mess=
age,
>just add it after the "---" after Signed-off-by.
>
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> ---
>>  vl.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>

>> @@ -4071,10 +4072,12 @@ int main(int argc, char **argv, char **envp)
>>          exit(1);
>>      }
>>
>> +#ifdef CONFIG_SECCOMP
>>      if (qemu_opts_foreach(qemu_find_opts("sandbox"),
>>                            parse_sandbox, NULL, NULL)) {
>>          exit(1);
>>      }
>> +#endif
>>
>>      if (qemu_opts_foreach(qemu_find_opts("name"),
>>                            parse_name, NULL, NULL)) {
>> --
>> Yi Min
>>
>
>I just wanted a review from J=E1n, since he is the author of the original =
libvirt
>patch. Does this breaks libvirt logic in any way? If not, ACK on this patc=
h.
>

Current libvirt logic assumes the -sandbox option is always present.
(IIRC it was introduced in QEMU 1.1 and when we switched from help
 scraping to capability probing via QMP for QEMU 1.2, there was no
 way to detect it)

This patch fixes the usage of QEMU new enough for seccomp blacklist
(where libvirt enables the sandbox by default),
but breaks the usage of QEMU with compiled out sandbox and
setting
  seccomp_sandbox =3D 0
in libvirt's qemu.conf:

error: internal error: process exited while connecting to monitor:
qemu-git: -sandbox off: There is no option group 'sandbox'


But now libvirt requires QEMU >=3D 1.5.0 which already supports
query-command-line-options, so if you want the option gone completely
--without-seccomp, I can add the code that probes for it and
make seccomp_sandbox =3D 0 a no-op if it's compiled out.

Jano

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlr+hiUACgkQyvpdPXT/
AmnmWRAAhHbOjaSrMYbF+tFTZxdyPBP/HGZIoB0zTgpug+o7RV9OGYURRpzOfrO1
bYKaxX1xL1qwHYWijyLQMrcVbU7k7OC7F73J9P5wvK+gMYQMg/3cZRm/a7g2gabw
q5CAZZJ0knAiX/u2Kcl8/QWbrSPJ7PJGQtcqSlZFOITpmkrXNEHYrzVFF/8LIIVx
saOLoKEiD/uYOLsWlgh1se1W+SQDfem4SvlHZmFdfaymGMAyVOBE6j9bLRfSzitj
u1DClO4VBdkm6VJFCTwttgII/sZVhgL2b/z4fCDrThT4XK0LQ8G/n4v52CHVQayA
xaUmsaPnifMau6RrHSoE/KWIf0nClVVoM4x3fQF8zVoIobXWd9kyeuPVGbjcOKmt
306xWIwHvpvduAIROCBNTNnomi0GctyPToWToCqi8oJ1UaeLMmknFBpGfJ99wSj8
qlJ55akgqNvbP+JN3XVCuvLKujxvNRHKIKwy4wR99tHt+8VDQjLSKP68dUooElAH
OKG+PuVw+t45QOaqjiQWAFdYyOljuJiQjCHdOmQy9uriGJo/dJel5gcsyJd9mTny
GwXxNTWqUGfBAoSicajck00RlGURu8+SwRJFHhtzC0KV5Z8kxXpN8tT0koH7b6np
T4IRuvzrI5AyPVwkdBh4fPTRdNvWahYPxeD9nL04VEWekjYhwlY=
=hIsf
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
