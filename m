Received: from eggs.gnu.org ([2001:4830:134:3::10]:34369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e25pa-0007Ou-KU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e25pX-00076z-GS
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:29:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e25pX-000769-8W
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:29:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9B1SbZw063605
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 21:28:59 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh71cpcxc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 21:28:59 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 19:28:58 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-34-marcandre.lureau@redhat.com>
	<c2e72712-5f40-1fd8-f161-9d31887f63fe@linux.vnet.ibm.com>
	<594422884.28308183.1507673953337.JavaMail.zimbra@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 21:28:54 -0400
MIME-Version: 1.0
In-Reply-To: <594422884.28308183.1507673953337.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c8264d4f-aa03-289c-e1d3-7eac5d81ea1e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 33/42] tpm-passthrough: remove error
 cleanup from handle_device_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, amarnath valluri <amarnath.valluri@intel.com>

On 10/10/2017 06:19 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> ----- Original Message -----
>> On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> Clean-up is handled by the create() function.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/tpm/tpm_passthrough.c | 15 ++-------------
>>>    1 file changed, 2 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
>>> index aa9167e3c6..0806cf86af 100644
>>> --- a/hw/tpm/tpm_passthrough.c
>>> +++ b/hw/tpm/tpm_passthrough.c
>>> @@ -261,27 +261,16 @@ tpm_passthrough_handle_device_opts(TPMPassthruS=
tate
>>> *tpm_pt, QemuOpts *opts)
>>>        if (tpm_pt->tpm_fd < 0) {
>>>            error_report("Cannot access TPM device using '%s': %s",
>>>                         tpm_pt->tpm_dev, strerror(errno));
>>> -        goto err_free_parameters;
>>> +        return -1;
>>>        }
>>>
>>>        if (tpm_util_test_tpmdev(tpm_pt->tpm_fd, &tpm_pt->tpm_version)=
) {
>>>            error_report("'%s' is not a TPM device.",
>>>                         tpm_pt->tpm_dev);
>>> -        goto err_close_tpmdev;
>>> +        return -1;
>>>        }
>> I would prefer the cleanup to happen in the functions where the state =
is
>> created...
> This is the role for a destructor, no need to worry about local object =
change cleanup.
>
> I can drop the patch if you feel strongly about it, but I think it's a =
nice code simplification.
>
I like to see the cleanup code on the bottom...
