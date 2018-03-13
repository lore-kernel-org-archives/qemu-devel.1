Received: from eggs.gnu.org ([2001:4830:134:3::10]:42111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eviEk-0005ty-KR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eviEh-0003A9-IQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:36:58 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eviEh-00039P-Ax
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:36:55 -0400
Received: by mail-wr0-f181.google.com with SMTP id d10so9205011wrf.3
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 04:36:55 -0700 (PDT)
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-25-brijesh.singh@amd.com>
	<0218f497-d397-0f49-3256-79d461e25be2@redhat.com>
	<a76057f1-ca48-721c-7c5d-948a0b2b7917@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12fc57d6-f3cc-1054-1618-8780dbf0ae5d@redhat.com>
Date: Tue, 13 Mar 2018 12:36:49 +0100
MIME-Version: 1.0
In-Reply-To: <a76057f1-ca48-721c-7c5d-948a0b2b7917@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 24/28] sev/i386: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Borislav Petkov <bp@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Bruce Rogers <brogers@suse.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 13/03/2018 12:28, Brijesh Singh wrote:
> 
> 
> On 3/13/18 4:33 AM, Paolo Bonzini wrote:
>> On 08/03/2018 13:48, Brijesh Singh wrote:
>>>      sev_set_guest_state(SEV_STATE_RUNNING);
>>> +
>>> +    /* add migration blocker */
>>> +    error_setg(&sev_mig_blocker,
>>> +               "SEV: Migration is not implemented");
>>> +    ret = migrate_add_blocker(sev_mig_blocker, &local_err);
>>> +    if (local_err) {
>>> +        error_report_err(local_err);
>>> +        error_free(sev_mig_blocker);
>>> +        exit(1);
>>> +    }
>>>  }
>> I think this should be in sev_guest_init instead?  Does migration
>> transfer the measurement, or is it lost forever?  Not a blocker though.
> 
> The launch measurement does not get transferred during the migration.
> During migration we get totally different measurement which is wrapped
> with transport key etc and that need to send to destination. IIRC, in my
> first attempt I was adding this blocker in sev_guest_init() but
> migration_add_blocker() was failing because  sev_guest_init() is called
> before the migration_object_init().

I see, thanks.  I'm not going to touch this part anyway. :)

We can fix it during the freeze period.

Paolo
