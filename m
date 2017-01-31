Received: from eggs.gnu.org ([2001:4830:134:3::10]:48047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cYjaV-0000iZ-0r
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cYjaQ-0004cN-T0
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:19:55 -0500
Received: from mail-db5eur01on0090.outbound.protection.outlook.com
	([104.47.2.90]:59648
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cYjaQ-0004cH-75
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:19:50 -0500
References: <1485857239-14296-1-git-send-email-den@openvz.org>
	<5f9269e3-0cff-0916-cecf-f21a68337c0f@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <d26e3800-e0bb-2c89-f704-bc7ce1ec9393@openvz.org>
Date: Tue, 31 Jan 2017 18:46:38 +0300
MIME-Version: 1.0
In-Reply-To: <5f9269e3-0cff-0916-cecf-f21a68337c0f@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] kvm: log available guest crash
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 01/31/2017 06:43 PM, Paolo Bonzini wrote:
>
> On 31/01/2017 05:07, Denis V. Lunev wrote:
>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>
>> Windows reports BSOD parameters through Hyper-V crash MSRs. This
>> information is very useful for initial crash analysis and thus
>> it would be nice to see it in the QEMU log file. There is suitable
>> log mask for the purpose.
>>
>> Linux guest does not provide this information, but still it would
>> be nice to log that we have crashed.
> We tell libvirt that the guest crashed through a QMP event, so I think
> this should be passed as arguments of the QMP event.  You could add:
>
> - a QAPI type GuestPanicInformation
>
> {'union': 'GuestPanicInformation',
>  'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
>
> {'struct': 'GuestPanicInformationHyperV',
>  'data': { 'arg1': 'uint64',
>            'arg2': 'uint64',
>            'arg3': 'uint64',
>            'arg4': 'uint64' } }
>
> - a QOM property on the CPU object, crash-information, whose getter
> returns an error unless cpu->crash_occurred = true
>
> - an optional GuestPanicInformation argument to the GUEST_PANICKED
> event, which is passed if the QOM property returns a non-error value
I like the idea of the event but also want to have the log message.
LOG_GUEST_ERROR level fits well to the idea at my opinion.

Thank you for the idea :)

Den
