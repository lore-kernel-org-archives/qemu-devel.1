Received: from eggs.gnu.org ([2001:4830:134:3::10]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWeNB-0007Au-Ek
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWeN6-0006HZ-LJ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:26:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWeN6-0006H8-Ej
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:26:00 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <61064b31-b6d5-97b1-89a4-5af719223e5a@redhat.com> (Eric Blake's
	message of "Tue, 2 Jan 2018 15:22:28 -0600")
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131647eucas1p1b5fb0616e683e78fdca767d267400f50@eucas1p1.samsung.com>
	<1509369390-8285-3-git-send-email-a.perevalov@samsung.com>
	<61064b31-b6d5-97b1-89a4-5af719223e5a@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 09:25:52 +0100
Message-ID: <87efn74acv.fsf@secure.laptop>
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
To: Eric Blake <eblake@redhat.com>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org, heetae82.ahn@samsung.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

Eric Blake <eblake@redhat.com> wrote:
> On 10/30/2017 08:16 AM, Alexey Perevalov wrote:
>> This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID,
>> in case when this feature is provided by kernel.
>
> Either 'in the case when this feature' or 'in case this feature'.
>
>> 
>> PostcopyBlocktimeContext is incapsulated inside postcopy-ram.c,
>
> s/incapsulated/encapsulated/
>
>> due to it's postcopy only feature.
>
> s/it's postcopy only/it being a postcopy-only/


>
>> Also it defines PostcopyBlocktimeContext's instance live time.
>> Information from PostcopyBlocktimeContext instance will be provided
>> much after postcopy migration end, instance of PostcopyBlocktimeContext
>> will live till QEMU exit, but part of it (vcpu_addr,
>> page_fault_vcpu_time) used only during calculation, will be released
>> when postcopy ended or failed.
>> 
>> To enable postcopy blocktime calculation on destination, need to request
>> proper capabiltiy (Patch for documentation will be at the tail of the patch
>
> s/capabiltiy/capability/

Changed for the pull request


>
>> set).
>> 
>> As an example following command enable that capability, assume QEMU was
>> started with
>> -chardev socket,id=charmonitor,path=/var/lib/migrate-vm-monitor.sock
>> option to control it
>> 
>> [root@host]#printf "{\"execute\" : \"qmp_capabilities\"}\r\n \
>> {\"execute\": \"migrate-set-capabilities\" , \"arguments\":   {
>> \"capabilities\": [ { \"capability\": \"postcopy-blocktime\", \"state\":
>> true } ] } }" | nc -U /var/lib/migrate-vm-monitor.sock
>> 
>> Or just with HMP
>> (qemu) migrate_set_capability postcopy-blocktime on
>> 
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> ---
