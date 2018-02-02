Received: from eggs.gnu.org ([2001:4830:134:3::10]:35187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ehd2O-0001Nc-DQ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ehd2L-00011X-4m
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:14:00 -0500
Received: from mail-co1nam03on0075.outbound.protection.outlook.com
	([104.47.40.75]:27274
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ehd2K-00010s-Na
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:13:57 -0500
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-19-brijesh.singh@amd.com>
	<20180130200838.GB2319@work-vm>
	<0abe3fee-a970-dc82-fd92-ad923bfa863a@amd.com>
	<20180201172709.GJ2457@work-vm>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <07d86670-e960-db04-52a9-5e6ecee18bc3@amd.com>
Date: Fri, 2 Feb 2018 09:11:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180201172709.GJ2457@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 18/23] sev: emit the SEV_MEASUREMENT
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Chen, Xiaogang" <Xiaogang.Chen@amd.com>



On 02/01/2018 11:27 AM, Dr. David Alan Gilbert wrote:
> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>>
>>
>> On 1/30/18 2:08 PM, Dr. David Alan Gilbert wrote:
>>> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>>>> During machine creation we encrypted the guest bios image, the
>>>> LAUNCH_MEASURE command can be used to retrieve the measurement of
>>>> the encrypted memory region. Emit the SEV_MEASUREMENT event so that
>>>> libvirt can grab the measurement value as soon as we are done with
>>>> creating the encrypted machine.
>>> Can you ust clarify what happens if the libvirt has disconnected and
>>> reconnected to qemu and so didn't see the event?  Can the reconnecting
>>> libvirt query it and find out it's ready/not ready yet?
>>
>> Dave,
>>
>> I have not looked into details between libvirt and qemu interaction to
>> comment how and when the events will be delivered. Recently, one of my
>> colleague was implementing libvirt interface for the SEV guest and ran
>> into somewhat a similar challenge and posted question on libvirt mailing
>> list [1].
>>
>> In previous discussion on qemu mailing list, we agreed to implement SEV
>> MEASUREMENT event which can be seen by libvirt. That's what this patch
>> is doing.
>>
>> But during the libvirt implementation it seems that qemu monitor
>> silently drops all the events before it get the first qmp_capabilities
>> command. At a quick glance it seems on reconnect, libvirt issues
>> qmp_capabilities command and any event issued before the
>> qmp_capabilities command will never to delivered to libvirt. we are
>> looking for=C2=A0 help from libvirt/qemu monitor experts on how we solve=
 this
>> problem. Our goal is to provide the measurement to libvirt before
>> libvirt issues "continue" command. Since event can't be seen by libvirt
>> before it resumes the guest hence I was wondering if we should we should
>> drop the SEV measurement event and consider adding a new QMP command to
>> query the SEV measurement.
>=20
> Yep, I'll leave it to the libvirt contacts for the best way they'd like
> to see that, as Eric says there's nothing wrong with having both the
> command and event if useful.  Also keep in mind coping with a guest that
> crashes early or that measurement never arrives.
>=20

Yep, lets see what libvirt experts say about it.

Hi Daniel,

Do you have any recommendation on whether we should consider adding a=20
new QMP to retrieve the measurement or we do event or both? Please note=20
that the launch measurement is generate only once for the lifetime of=20
the guest. The measurement will be available after qmeu encrypts the=20
guest bios during the machine initialization time.

-Brijesh
