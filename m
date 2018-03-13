Received: from eggs.gnu.org ([2001:4830:134:3::10]:39236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1evi6P-0001zy-GN
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1evi6L-0004lk-I5
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:28:21 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com
	([104.47.40.79]:9984
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1evi6L-0004kp-7u
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:28:17 -0400
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-25-brijesh.singh@amd.com>
	<0218f497-d397-0f49-3256-79d461e25be2@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a76057f1-ca48-721c-7c5d-948a0b2b7917@amd.com>
Date: Tue, 13 Mar 2018 06:28:03 -0500
MIME-Version: 1.0
In-Reply-To: <0218f497-d397-0f49-3256-79d461e25be2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v12 24/28] sev/i386: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>



On 3/13/18 4:33 AM, Paolo Bonzini wrote:
> On 08/03/2018 13:48, Brijesh Singh wrote:
>>      sev_set_guest_state(SEV_STATE_RUNNING);
>> +
>> +    /* add migration blocker */
>> +    error_setg(&sev_mig_blocker,
>> +               "SEV: Migration is not implemented");
>> +    ret =3D migrate_add_blocker(sev_mig_blocker, &local_err);
>> +    if (local_err) {
>> +        error_report_err(local_err);
>> +        error_free(sev_mig_blocker);
>> +        exit(1);
>> +    }
>>  }
> I think this should be in sev_guest_init instead?  Does migration
> transfer the measurement, or is it lost forever?  Not a blocker though.

The launch measurement does not get transferred during the migration.
During migration we get totally different measurement which is wrapped
with transport key etc and that need to send to destination. IIRC, in my
first attempt I was adding this blocker in sev_guest_init() but
migration_add_blocker() was failing because=C2=A0 sev_guest_init() is calle=
d
before the migration_object_init().

>
> Paolo
