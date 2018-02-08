Received: from eggs.gnu.org ([2001:4830:134:3::10]:59390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1ejiv4-00011n-Fz
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1ejiuz-0001li-Jb
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:55:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45058
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rnsastry@linux.vnet.ibm.com>)
	id 1ejiuw-0001k4-0Z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:55:01 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w189sdTD003611
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 04:54:56 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g0kpp1y7b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 04:54:56 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <rnsastry@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 04:54:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 08 Feb 2018 15:26:16 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
In-Reply-To: <381c5681-a194-6750-06ac-7afeda9173f7@vivier.eu>
References: <151799695576.147.5866177190489987115@bdbb90650ae5>
	<381c5681-a194-6750-06ac-7afeda9173f7@vivier.eu>
Message-Id: <56e236398cf70cc2f2b431ea7660b3bd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [patch] linux-user/syscall.c: Fix missing break
 for host_to_target_cmsg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 2018-02-07 19:27, Laurent Vivier wrote:
> Le 07/02/2018 =C3=A0 10:49, no-reply@patchew.org a =C3=A9crit=C2=A0:
>> Hi,
>>=20
>> This series failed build test on s390x host. Please find the details=20
>> below.
> ...
>>   CC      aarch64_be-linux-user/linux-user/syscall.o
>> In file included from=20
>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/qemu.h:16:0,
>>                  from=20
>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c:118:
>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c: In=20
>> function =E2=80=98do_sendrecvmsg_locked=E2=80=99:
>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall_defs.h:308=
:61:=20
>> error: =E2=80=98tgt_len=E2=80=99 may be used uninitialized in this fun=
ction=20
>> [-Werror=3Dmaybe-uninitialized]
>>  #define TARGET_CMSG_LEN(len) (sizeof(struct target_cmsghdr) + (len))
>>                                                              ^
>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c:1797:13:=
=20
>> note: =E2=80=98tgt_len=E2=80=99 was declared here
>>          int tgt_len, tgt_space;
>>              ^~~~~~~
>=20
> it seems gcc disagrees with Coverity...
>=20
> I think this should fixed like:
>=20
>  diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 74378947f0..d7fbe334eb 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1824,8 +1824,10 @@ static inline abi_long=20
> host_to_target_cmsg(struct
> target_msghdr *target_msgh,
>                  tgt_len =3D sizeof(struct target_timeval);
>                  break;
>              default:
> +                tgt_len =3D len;
>                  break;

In my view this will result in assigning a wrong value to =E2=80=98tgt_le=
n=E2=80=99=20
at this =E2=80=98switch-case=E2=80=99 condition.
Instead looking at the option of initializing =E2=80=98tgt_len' to =E2=80=
=980=E2=80=99.

@@ -1789,7 +1789,7 @@
         void *target_data =3D TARGET_CMSG_DATA(target_cmsg);

         int len =3D cmsg->cmsg_len - sizeof(struct cmsghdr);
-        int tgt_len, tgt_space;
+        int tgt_len =3D 0, tgt_space;

         /* We never copy a half-header but may copy half-data;
          * this is Linux's behaviour in put_cmsg(). Note that
@@ -1821,6 +1821,7 @@
             default:
                 break;
             }
+        break;
         default:
             tgt_len =3D len;
             break;

Re-sending this mail because earlier one not reached the mailing list.=20
Please accept my apologies if it is a duplicate.

>              }
> +            break;
>          default:
>              tgt_len =3D len;
>              break;
>=20
> Peter?
>=20
> Thanks,
> Laurent

--=20
Regards,
R.Nageswara Sastry
