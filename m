Received: from eggs.gnu.org ([2001:4830:134:3::10]:54431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv4DE-0002ka-IB
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv4DA-00026x-BR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:20:28 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:53737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv4DA-00025H-4f
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:20:24 -0400
Received: by mail-wr0-f180.google.com with SMTP id l22so5039150wrc.10
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 09:20:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20170919102434.21147-1-pbonzini@redhat.com>
	<20170919102434.21147-5-pbonzini@redhat.com>
	<20170919125300.GL9536@redhat.com>
	<d80b9409-9524-4a05-d0a3-d3e8f23c416b@redhat.com>
	<20170919131208.GM9536@redhat.com>
	<ddc23258-0e68-f2e3-72a3-c16e443a7143@redhat.com>
Message-ID: <3952279a-b001-db23-ce5f-763bbcadd996@redhat.com>
Date: Thu, 21 Sep 2017 18:20:18 +0200
MIME-Version: 1.0
In-Reply-To: <ddc23258-0e68-f2e3-72a3-c16e443a7143@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/4] scsi: add persistent
 reservation manager using qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 19/09/2017 15:23, Paolo Bonzini wrote:
> On 19/09/2017 15:12, Daniel P. Berrange wrote:
>> On Tue, Sep 19, 2017 at 02:57:00PM +0200, Paolo Bonzini wrote:
>>> On 19/09/2017 14:53, Daniel P. Berrange wrote:
>>>>> +    /* Try to reconnect while sending the CDB.  */
>>>>> +    for (attempts = 0; attempts < PR_MAX_RECONNECT_ATTEMPTS; attempts++) {
>>>>
>>>> I'm curious why you need to loop here. The helper daemon should be running
>>>> already, as you're not spawning it on demand IIUC. So it shoudl either
>>>> succeed first time, or fail every time.
>>>
>>> You're focusing on the usecase where the helper daemon is spawned per-VM
>>> by the system libvirtd, which I agree is the most important one.
>>> However, the other usecase is the one with a global daemon, access to
>>> which is controlled via Unix permissions.  This is not SELinux-friendly,
>>> but it is nicer for testing and it is also the only possibility for user
>>> libvirtd.
>>>
>>> In that case, upgrading QEMU on the host could result in a "systemctl
>>> restart qemu-pr-helper.service" (or, hopefully unlikely, a crash could
>>> result in systemd respawning the daemon).  Reconnect is useful in that case.
>>
>> If using systemd socket activation and you restart the daemon, the listening
>> socket should be preserved, so you shouldn't need to reconnect - the client
>> should get queued until it has started again (likewise on crash).
> 
> Oh, that's cool.  I didn't know that.

... wait, I do need to reconnect, because the active socket is closed.
I only don't need to retry and wait between the retries.

Paolo
