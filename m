Received: from eggs.gnu.org ([209.51.188.92]:32924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwJCG-0001jL-Us
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 23:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwIzd-0007FY-5l
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:56:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gwIza-0007E1-Ui
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:56:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<d935f740-e792-1b7b-80ed-eb400ee14a3d@redhat.com>
Date: Wed, 20 Feb 2019 04:56:08 +0100
In-Reply-To: <d935f740-e792-1b7b-80ed-eb400ee14a3d@redhat.com> (Eric Blake's
	message of "Tue, 19 Feb 2019 14:12:21 -0600")
Message-ID: <8736ojkt9j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org, natalia.fursova@ispras.ru, arikalo@wavecomp.com, mdroth@linux.vnet.ibm.com, dovgaluk@ispras.ru, amarkovic@wavecomp.com, marcandre.lureau@redhat.com, philmd@redhat.com, aurelien@aurel32.net

Eric Blake <eblake@redhat.com> writes:

> On 2/19/19 1:15 PM, Aleksandar Markovic wrote:
>> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>=20
>> This patch enables QMP-based querying of the available CPU types for
>> MIPS and MIPS64 platforms.
>>=20
>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>
>> +++ b/qapi/target.json
>> @@ -499,7 +499,7 @@
>>              'static': 'bool',
>>              '*unavailable-features': [ 'str' ],
>>              'typename': 'str' },
>> -  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I=
386) || defined(TARGET_S390X)' }
>> +  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I=
386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
>
> Hmm. Long line; however, the argument to 'if' is pasted literally to an
> #if directive, which would break if we added newlines in the middle.
> And we can't use literal newlines in the middle of a JSON string.  About
> the only thing I could think of that might allow for more manageable
> line lengths would be permitting:
>
> 'if': [ 'defined(TARGET_PPC)',
>         'defined(TARGET_ARM)' ...]
>
> where the QAPI generator would in turn form the disjunction of supplying
> the || between each term when the 'if' is an array of strings. But that
> feels like a lot of effort for little gain compared to just living with
> the long lines.

I hate long lines as much as anyone, but we already burned the list
syntax on conjunction:

docs/devel/qapi-code-gen.txt:

    =3D=3D=3D Configuring the schema =3D=3D=3D

    The 'struct', 'enum', 'union', 'alternate', 'command' and 'event'
    top-level expressions can take an 'if' key.  Its value must be a string
    or a list of strings.  A string is shorthand for a list containing just
    that string.  The code generated for the top-level expression will then
    be guarded by #if COND for each COND in the list.

    Example: a conditional struct

     { 'struct': 'IfStruct', 'data': { 'foo': 'int' },
       'if': ['defined(CONFIG_FOO)', 'defined(HAVE_BAR)'] }

    gets its generated code guarded like this:

     #if defined(CONFIG_FOO)
     #if defined(HAVE_BAR)
     ... generated code ...
     #endif /* defined(HAVE_BAR) */
     #endif /* defined(CONFIG_FOO) */

The problem of long strings requiring long lines is not limited to 'if'.
The common solution in programming languages is to concatenate adjacent
string literals.  A more user-friendly QAPI language would support
something like that.  By choosing JSON, a language designed "for the
serialization of structured data" (RFC 4627, 7159, 8259), we opted
against user-friendly.  We then admitted our regrets halfheartedly by
making our version of JSON incompatible enough to defeat tools like
javascript-mode.  Correcting our fundamental mistake now would be a lot
of churn.
