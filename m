Received: from eggs.gnu.org ([2001:4830:134:3::10]:38582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eylb3-0003lu-1C
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eylb0-0003S4-Ef
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:48:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39984
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eylb0-0003QQ-7k
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:48:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LLhnnh076668
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 17:48:32 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2guvmsff9m-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 17:48:32 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 17:48:31 -0400
References: <1521253498-6834-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<20180321200440.GA3466@work-vm>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 17:48:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180321200440.GA3466@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0e1b16ae-e2a3-67a8-a85e-71b68d163791@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5.2 for 2.13 0/4] tpm: Extend TPM with
 state migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com

On 03/21/2018 04:04 PM, Dr. David Alan Gilbert wrote:
> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>> This series of patches implements support for migrating the state of t=
he
>> external 'swtpm' TPM emulator as well as that of the TIS interface.
>>
>> For testing of TPM 2 (migration) please use the following git repos an=
d
>> branches:
>>
>> libtpms:
>>     - repo: https://github.com/stefanberger/libtpms
>>     - branch: tpm2-preview.rev146.v2
>>
>> swtpm:
>>     - repo: https://github.com/stefanberger/swtpm
>>     - branch: tpm2-preview.rev146.v2
> I don't see that branch in the swtpm tree:
> [dgilbert@dgilbert-t530 swtpm]$ git branch -a
> * (HEAD detached at origin/master)
>    master
>    remotes/origin/HEAD -> origin/master
>    remotes/origin/coverity_scan
>    remotes/origin/master
>    remotes/origin/master.next
>    remotes/origin/tpm2-preview
>    remotes/origin/tpm2-preview.v2

It's this one. Above is type.

Thanks for the reviews.

    Stefan

>
> (I need to untangle my system libtpms from that specific version to get=
 it to build as
> well)
>
> Dave
>
>> Regards,
>>    Stefan
>>
>> Changes:
>>   v4->v5:
>>     - followed Marc-Andr=E9's and Alan's comments where possible; some=
 comments
>>       were not addressed and reasons posted to mailing list
>>     - converted debug statements to tracing
>>     - qemu_chr_fe_read_all does not return errno, so displaying expect=
ed versus
>>       received number of bytes rather than strerror(errno)
>>     - added test cases
>>     - added documentation for migration to docs/spec/tpm.txt
>>
>>   v3->v4:
>>     - dropped the size limit enforcement on blobs received from the sw=
tpm
>>     - the .post_load migration function requires errno's to be returne=
d.
>>       -> some of the functions have been converted to return a better =
errno
>>
>>
>> Stefan Berger (4):
>>    tpm: extend TPM emulator with state migration support
>>    tpm: extend TPM TIS with state migration support
>>    docs: tpm: add VM save/restore example and troubleshooting guide
>>    tpm: Add test cases that uses the external swtpm with CRB interface
>>
>>   docs/specs/tpm.txt         | 106 +++++++++++++++
>>   hw/tpm/tpm_emulator.c      | 318 +++++++++++++++++++++++++++++++++++=
++++++++--
>>   hw/tpm/tpm_tis.c           |  52 +++++++-
>>   hw/tpm/trace-events        |   9 +-
>>   tests/Makefile.include     |   3 +
>>   tests/tpm-crb-swtpm-test.c | 244 ++++++++++++++++++++++++++++++++++
>>   tests/tpm-util.c           | 143 ++++++++++++++++++++
>>   tests/tpm-util.h           |  36 +++++
>>   8 files changed, 897 insertions(+), 14 deletions(-)
>>   create mode 100644 tests/tpm-crb-swtpm-test.c
>>   create mode 100644 tests/tpm-util.c
>>   create mode 100644 tests/tpm-util.h
>>
>> --=20
>> 2.5.5
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
