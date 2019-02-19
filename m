Received: from eggs.gnu.org ([209.51.188.92]:48077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwBki-0002Uj-30
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwBkg-0005z6-Eu
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:12:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gwBkg-0005vd-3H
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:12:26 -0500
References: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d935f740-e792-1b7b-80ed-eb400ee14a3d@redhat.com>
Date: Tue, 19 Feb 2019 14:12:21 -0600
MIME-Version: 1.0
In-Reply-To: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP
 query-cpu-definitions command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: natalia.fursova@ispras.ru, arikalo@wavecomp.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, dovgaluk@ispras.ru, amarkovic@wavecomp.com, marcandre.lureau@redhat.com, philmd@redhat.com, aurelien@aurel32.net

On 2/19/19 1:15 PM, Aleksandar Markovic wrote:
> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>=20
> This patch enables QMP-based querying of the available CPU types for
> MIPS and MIPS64 platforms.
>=20
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

> +++ b/qapi/target.json
> @@ -499,7 +499,7 @@
>              'static': 'bool',
>              '*unavailable-features': [ 'str' ],
>              'typename': 'str' },
> -  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_=
I386) || defined(TARGET_S390X)' }
> +  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_=
I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }

Hmm. Long line; however, the argument to 'if' is pasted literally to an
#if directive, which would break if we added newlines in the middle.
And we can't use literal newlines in the middle of a JSON string.  About
the only thing I could think of that might allow for more manageable
line lengths would be permitting:

'if': [ 'defined(TARGET_PPC)',
        'defined(TARGET_ARM)' ...]

where the QAPI generator would in turn form the disjunction of supplying
the || between each term when the 'if' is an array of strings. But that
feels like a lot of effort for little gain compared to just living with
the long lines.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
