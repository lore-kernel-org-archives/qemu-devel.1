Received: from eggs.gnu.org ([2001:4830:134:3::10]:46059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWTWo-0003bi-Sy
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWTWl-0008WJ-0Q
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:51:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWTWk-0008Vi-R4
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:51:14 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1509369390-8285-3-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Mon, 30 Oct 2017 16:16:26 +0300")
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131647eucas1p1b5fb0616e683e78fdca767d267400f50@eucas1p1.samsung.com>
	<1509369390-8285-3-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Tue, 02 Jan 2018 21:51:08 +0100
Message-ID: <87y3lg3ryb.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 2/6] migration: add postcopy blocktime
 ctx into MigrationIncomingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID,
> in case when this feature is provided by kernel.
>
> PostcopyBlocktimeContext is incapsulated inside postcopy-ram.c,
> due to it's postcopy only feature.
> Also it defines PostcopyBlocktimeContext's instance live time.
> Information from PostcopyBlocktimeContext instance will be provided
> much after postcopy migration end, instance of PostcopyBlocktimeContext
> will live till QEMU exit, but part of it (vcpu_addr,
> page_fault_vcpu_time) used only during calculation, will be released
> when postcopy ended or failed.
>
> To enable postcopy blocktime calculation on destination, need to request
> proper capabiltiy (Patch for documentation will be at the tail of the patch
> set).
>
> As an example following command enable that capability, assume QEMU was
> started with
> -chardev socket,id=charmonitor,path=/var/lib/migrate-vm-monitor.sock
> option to control it
>
> [root@host]#printf "{\"execute\" : \"qmp_capabilities\"}\r\n \
> {\"execute\": \"migrate-set-capabilities\" , \"arguments\":   {
> \"capabilities\": [ { \"capability\": \"postcopy-blocktime\", \"state\":
> true } ] } }" | nc -U /var/lib/migrate-vm-monitor.sock
>
> Or just with HMP
> (qemu) migrate_set_capability postcopy-blocktime on
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
