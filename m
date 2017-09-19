Received: from eggs.gnu.org ([2001:4830:134:3::10]:50787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duI5Y-0001nS-61
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duI5T-0007vy-8q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:57:20 -0400
References: <20170919102434.21147-1-pbonzini@redhat.com>
	<20170919102434.21147-5-pbonzini@redhat.com>
	<20170919125300.GL9536@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d80b9409-9524-4a05-d0a3-d3e8f23c416b@redhat.com>
Date: Tue, 19 Sep 2017 14:57:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170919125300.GL9536@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] scsi: add persistent reservation
 manager using qemu-pr-helper
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

On 19/09/2017 14:53, Daniel P. Berrange wrote:
>> +    /* Try to reconnect while sending the CDB.  */
>> +    for (attempts = 0; attempts < PR_MAX_RECONNECT_ATTEMPTS; attempts++) {
>
> I'm curious why you need to loop here. The helper daemon should be running
> already, as you're not spawning it on demand IIUC. So it shoudl either
> succeed first time, or fail every time.

You're focusing on the usecase where the helper daemon is spawned per-VM
by the system libvirtd, which I agree is the most important one.
However, the other usecase is the one with a global daemon, access to
which is controlled via Unix permissions.  This is not SELinux-friendly,
but it is nicer for testing and it is also the only possibility for user
libvirtd.

In that case, upgrading QEMU on the host could result in a "systemctl
restart qemu-pr-helper.service" (or, hopefully unlikely, a crash could
result in systemd respawning the daemon).  Reconnect is useful in that case.

Paolo
