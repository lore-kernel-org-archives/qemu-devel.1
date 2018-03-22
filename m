Received: from eggs.gnu.org ([2001:4830:134:3::10]:54800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eywC2-0003fA-WC
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eywBz-0005E7-Rg
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:07:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eywBz-0005Da-Li
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:07:27 -0400
Date: Thu, 22 Mar 2018 09:07:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180322090714.GA3205@work-vm>
References: <1521253498-6834-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1521253498-6834-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<20180321171402.GF3465@work-vm>
	<ec539c1c-37bb-afaf-9a8b-99e6c4f44f4f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec539c1c-37bb-afaf-9a8b-99e6c4f44f4f@linux.vnet.ibm.com>
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com

* Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> On 03/21/2018 01:14 PM, Dr. David Alan Gilbert wrote:
> > * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> > > +
> > > +    if (totlength > 0) {
> > > +        tsb->buffer = g_try_malloc(totlength);
> > > +        if (!tsb->buffer) {
> > > +            error_report("tpm-emulator: Out of memory allocating %u bytes",
> > > +                         totlength);
> > > +            return -1;
> > > +        }
> > > +
> > > +        n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr, tsb->buffer, totlength);
> > > +        if (n != totlength) {
> > > +            error_report("tpm-emulator: Could not read stateblob (type %d); "
> > > +                         "expected %u bytes, got %zd",
> > > +                         type, totlength, n);
> > I think you need to free tsb->buffer here.
> 
> tpm_emulator_get_state_blobs() below clears all 3 buffers in case one error
> is encountered.

Ah OK.

Dave

> > 
> > Other than that, I think:
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> > 
> > > +            return -1;
> > > +        }
> > > +    }
> > > +    tsb->size = totlength;
> > > +
> > > +    trace_tpm_emulator_get_state_blob(type, tsb->size, *flags);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
> > > +{
> > > +    TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
> > > +
> > > +    if (tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
> > > +                                    &state_blobs->permanent,
> > > +                                    &state_blobs->permanent_flags) < 0 ||
> > > +        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
> > > +                                    &state_blobs->volatil,
> > > +                                    &state_blobs->volatil_flags) < 0 ||
> > > +        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
> > > +                                    &state_blobs->savestate,
> > > +                                    &state_blobs->savestate_flags) < 0) {
> > > +        goto err_exit;
> > > +    }
> > > +
> > > +    return 0;
> > > +
> > > + err_exit:
> > > +    tpm_sized_buffer_reset(&state_blobs->volatil);
> > > +    tpm_sized_buffer_reset(&state_blobs->permanent);
> > > +    tpm_sized_buffer_reset(&state_blobs->savestate);
> 
> ^^^ here
> 
> > > +
> > > +    return -1;
> > > +}
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
