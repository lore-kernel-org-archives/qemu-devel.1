Received: from eggs.gnu.org ([209.51.188.92]:57166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyzkC-0002ad-Ih
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyzkA-0007HP-JQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:59:32 -0500
References: <20190227012132.16271-1-david@gibson.dropbear.id.au>
	<20190227110127.GE31688@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9f4a52e-43e0-c209-4743-2f039e96a6b9@redhat.com>
Date: Wed, 27 Feb 2019 07:59:11 -0600
MIME-Version: 1.0
In-Reply-To: <20190227110127.GE31688@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Allow -sandbox off with --disable-seccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: otubo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/27/19 5:01 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 27, 2019 at 12:21:32PM +1100, David Gibson wrote:
>> At present, when seccomp support is compiled out with --disable-seccom=
p
>> we fail with an error if the user puts -sandbox on the command line.
>>
>> That kind of makes sense, but it's a bit strange that we reject a requ=
est
>> to disable sandboxing with "-sandbox off" saying we don't support
>> sandboxing.
>>
>> This puts in a small sandbox to (correctly) silently ignore -sandbox o=
ff
>> when we don't have sandboxing support compiled in.  This makes life ea=
sier
>> for testcases, since they can safely specify "-sandbox off" without ha=
ving
>> to care if the qemu they're using is compiled with sandbox support or =
not.
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

> '-sandbox off'  is just syntax sugar for '-sandbox enable=3Doff', with
> the default arg name handled by QemuOpts.

Except that libvirt probes, via query-command-line-options, whether the
'-sandbox' option supports the 'enable' key.  You risk breaking
introspection (where libvirt knows NOT to use enable=3Don|off) if -sandbo=
x
enable=3Doff is advertised even when the feature is not compiled in.

>=20
> If we want to keep ability to run "-sandbox off" we should do it via
> the QEMU opts code we already have in the first part of the conditional=
,
> so that "-sandbox enable=3Doff" also works as normal.
>=20
> Essentially we need to push the #ifdef CONFIG_SECCOMP down into the
> parse_sandbox method, so that it parses the "enable" option normally
> but rejects any value except disabled..
>=20
> The QemuOptsList should also be conditional to only register the
> "enable"  arg and not the other bits.

Whatever we do here had better be careful that the introspection used by
libvirt doesn't break, when libvirt is trying to learn when seccomp was
not compiled in.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
