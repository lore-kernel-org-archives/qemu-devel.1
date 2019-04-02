Received: from eggs.gnu.org ([209.51.188.92]:39139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJId-0003zh-QW
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJIc-0005J6-Rn
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:17:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBJIc-0005BB-Jo
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:17:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190401090827.20793-1-armbru@redhat.com>
	<20190401090827.20793-5-armbru@redhat.com>
	<20190402121455.GB2861@work-vm>
Date: Tue, 02 Apr 2019 15:11:41 +0200
In-Reply-To: <20190402121455.GB2861@work-vm> (David Alan Gilbert's message of
	"Tue, 2 Apr 2019 13:14:55 +0100")
Message-ID: <87mul8blgy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/5] vl: Document dependencies hiding in
 global and compat props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: kwolf@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, anthony.perard@citrix.com, imammedo@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  vl.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>> 
>> diff --git a/vl.c b/vl.c
>> index e4d7ad6b85..8c6d06b01d 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4285,16 +4285,36 @@ int main(int argc, char **argv, char **envp)
>>      current_machine->maxram_size = maxram_size;
>>      current_machine->ram_slots = ram_slots;
>>  
>> +    /*
>> +     * Note: uses machine properties such as kernel-irqchip, must run
>> +     * after machine_set_property().
>> +     */
>>      configure_accelerator(current_machine, argv[0]);
>>  
>> +    /*
>> +     * Beware, QOM objects created before this point miss global and
>> +     * compat properties.
>> +     *
>> +     * Global properties get set up by qdev_prop_register_global(),
>> +     * called from user_register_global_props(), and certain option
>> +     * desugaring.
>
> Not to stop this patch series; but could we add a way to actually
> detect when this has happened?  Like setting a flag on QOM objects
> created before this point for example?

I started to work on something like this, but had to switch to more
urgent work.
