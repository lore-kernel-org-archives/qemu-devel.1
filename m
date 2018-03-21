Received: from eggs.gnu.org ([2001:4830:134:3::10]:45052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eylk6-0006Z4-Sh
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eylk3-0004IO-Jz
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:57:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eylk3-0004H4-Ap
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:57:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LLv6F0044276
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 17:57:53 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2guw2hxhqm-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 17:57:53 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 15:57:52 -0600
References: <1521253498-6834-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1521253498-6834-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<20180321171402.GF3465@work-vm>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 17:57:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180321171402.GF3465@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <ec539c1c-37bb-afaf-9a8b-99e6c4f44f4f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5.2 for 2.13 1/4] tpm: extend TPM emulator
 with state migration support
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

On 03/21/2018 01:14 PM, Dr. David Alan Gilbert wrote:
> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>> +
>> +    if (totlength > 0) {
>> +        tsb->buffer = g_try_malloc(totlength);
>> +        if (!tsb->buffer) {
>> +            error_report("tpm-emulator: Out of memory allocating %u bytes",
>> +                         totlength);
>> +            return -1;
>> +        }
>> +
>> +        n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr, tsb->buffer, totlength);
>> +        if (n != totlength) {
>> +            error_report("tpm-emulator: Could not read stateblob (type %d); "
>> +                         "expected %u bytes, got %zd",
>> +                         type, totlength, n);
> I think you need to free tsb->buffer here.

tpm_emulator_get_state_blobs() below clears all 3 buffers in case one 
error is encountered.

>
> Other than that, I think:
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>
>> +            return -1;
>> +        }
>> +    }
>> +    tsb->size = totlength;
>> +
>> +    trace_tpm_emulator_get_state_blob(type, tsb->size, *flags);
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
>> +{
>> +    TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
>> +
>> +    if (tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
>> +                                    &state_blobs->permanent,
>> +                                    &state_blobs->permanent_flags) < 0 ||
>> +        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
>> +                                    &state_blobs->volatil,
>> +                                    &state_blobs->volatil_flags) < 0 ||
>> +        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
>> +                                    &state_blobs->savestate,
>> +                                    &state_blobs->savestate_flags) < 0) {
>> +        goto err_exit;
>> +    }
>> +
>> +    return 0;
>> +
>> + err_exit:
>> +    tpm_sized_buffer_reset(&state_blobs->volatil);
>> +    tpm_sized_buffer_reset(&state_blobs->permanent);
>> +    tpm_sized_buffer_reset(&state_blobs->savestate);

^^^ here

>> +
>> +    return -1;
>> +}
