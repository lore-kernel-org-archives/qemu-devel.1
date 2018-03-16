Received: from eggs.gnu.org ([2001:4830:134:3::10]:47982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ewtqI-0008Jk-Hg
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ewtqE-0004Ql-G7
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:12:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40332
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ewtqE-0004QN-AP
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:12:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GI4prV097427
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 14:12:33 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grf21ar1u-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 14:12:33 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 16 Mar 2018 18:12:31 -0000
References: <20180316170122.fmo2nghyxpeaq7hp@kamzik.brq.redhat.com>
	<a876446f-d4a4-4df2-c986-4e45a64b9436@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 16 Mar 2018 19:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <a876446f-d4a4-4df2-c986-4e45a64b9436@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <c4054b32-b2e1-acd3-52f4-8f7d5c12c2a0@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu master build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

Does it make sense to have something like

diff --git a/configure b/configure
index 831ebf2..67d7ae3 100755
--- a/configure
+++ b/configure
@@ -552,6 +552,10 @@ else
     pwd_is_source_path=3D"n"
 fi
=20
+if test -f $source_path\/qemu-version.h -a $pwd_is_source_path =3D "n" ;=
 then
+error_exit "source path contains a stale configuration, cannot build out=
side"=20
+fi
+
 check_define() {
 cat > $TMPC <<EOF
 #if !defined($1)



On 03/16/2018 06:11 PM, Paolo Bonzini wrote:
> On 16/03/2018 18:01, Andrew Jones wrote:
>> Hi Thomas,
>>
>> QEMU master is failing to build on an AArch64 machine with GCC 4.8. I =
get
>>
>>   ...
>>   CC      qemu-nbd.o
>> /home/drjones/code/qemu/qemu-nbd.c: In function =E2=80=98version=E2=80=
=99:
>> /home/drjones/code/qemu/qemu-nbd.c:133:7: error: expected =E2=80=98)=E2=
=80=99 before =E2=80=98QEMU_FULL_VERSION=E2=80=99
>>  "%s " QEMU_FULL_VERSION "\n"
>>        ^
>> /home/drjones/code/qemu/qemu-nbd.c:139:5: error: format =E2=80=98%s=E2=
=80=99 expects a matching =E2=80=98char *=E2=80=99 argument [-Werror=3Dfo=
rmat=3D]
>>      , name);
>>      ^
>> cc1: all warnings being treated as errors
>> make: *** [qemu-nbd.o] Error 1
>>
>>
>> Reverting 7e563bfb8 fixes the build. I figured I'd report it now,
>> but I won't have time to look closer until Monday.
>=20
> You probably have a stray qemu-version.h file somewhere.  No worries, I
> was puzzled by the same thing after I applied Thomas's patch. :)
>=20
> Paolo
>=20
