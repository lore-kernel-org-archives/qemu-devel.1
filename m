Received: from eggs.gnu.org ([2001:4830:134:3::10]:43747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1eAeJO-0000qu-1y
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1eAeJK-0008NK-5w
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:55:14 -0400
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:34069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Cowgill@mips.com>)
	id 1eAeJJ-0008KC-Vv
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:55:10 -0400
References: <20171103120703.15749-1-james.cowgill@mips.com>
	<755effd6-c595-9487-75a6-073ade6be4bc@vivier.eu>
From: James Cowgill <James.Cowgill@mips.com>
Message-ID: <2cd7013c-f6c0-980b-0d8b-3ccd7d031299@mips.com>
Date: Fri, 3 Nov 2017 15:52:08 +0000
MIME-Version: 1.0
In-Reply-To: <755effd6-c595-9487-75a6-073ade6be4bc@vivier.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: return EINVAL from
 prctl(PR_*_SECCOMP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org

Hi,

On 03/11/17 14:29, Laurent Vivier wrote:
> Le 03/11/2017 =C3=A0 13:07, James Cowgill a =C3=A9crit=C2=A0:
>> If an application tries to install a seccomp filter using
>> prctl(PR_SET_SECCOMP), the filter is likely for the target instead of th=
e host
>> architecture. This will probably cause qemu to be immediately killed whe=
n it
>> executes another syscall.
>>
>> Prevent this from happening by returning EINVAL from both seccomp prctl
>> calls. This is the error returned by the kernel when seccomp support is
>> disabled.
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1726394
>> Signed-off-by: James Cowgill <james.cowgill@mips.com>
>> ---
>>  linux-user/syscall.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index d4497dec5d..43cd5fb2bb 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -10482,6 +10482,10 @@ abi_long do_syscall(void *cpu_env, int num, abi=
_long arg1,
>>              break;
>>          }
>>  #endif
>> +        case PR_GET_SECCOMP:
>> +        case PR_SET_SECCOMP:
>> +            ret =3D -TARGET_EINVAL;
>> +            break;
>>          default:
>>              /* Most prctl options have no pointer arguments */
>>              ret =3D get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
>>
>=20
> I think we should allow PR_GET_SECCOMP, and at least all the modes
> except SECCOMP_MODE_FILTER for PR_SET_SECCOMP.

I tried allowing SECCOMP_MODE_STRICT and made a small test program. It
seems that qemu is SIGKILLed when _exit is used because qemu itself
tries to call rt_sigprocmask which is not an allowed syscall.

PR_GET_SECCOMP can probably be allowed. My reasoning for disabling it
was to match the kernel behavior for when seccomp is disabled by the
Kconfig option.

Thanks,
James
