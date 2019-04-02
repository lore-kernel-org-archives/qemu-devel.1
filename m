Received: from eggs.gnu.org ([209.51.188.92]:41412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hBL0R-0008Og-1M
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hBL0N-0002Ka-L0
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:07:17 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hBL0N-0002G8-91
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:07:15 -0400
Received: by mail-ed1-x542.google.com with SMTP id d26so11967216ede.10
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 08:07:14 -0700 (PDT)
Date: Tue, 2 Apr 2019 15:07:10 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190402150710.gz4rs3rn4sy7khcl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190311060823.18360-2-richardw.yang@linux.intel.com>
	<87pnq4hq6z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnq4hq6z.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] vl.c: make find_default_machine() local
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com

On Tue, Apr 02, 2019 at 08:33:08AM +0200, Markus Armbruster wrote:
>Wei Yang <richardw.yang@linux.intel.com> writes:
>
>> Function find_default_machine() is introduced by commit 2c8cffa599b7
>> "vl: make find_default_machine externally visible", while it seems no
>> one outside use it.
>It was used outside of vl.c until commit a904410af5f.
>
>> This patch make it local again.
>
>Suggest:
>
>  Commit a904410af5f removed the only user of find_default_machine()
>  outside vl.c, but neglected to make it static.  Do that now.
>

Markus

Thanks for your comments.

BTW, I think I need to spin a v2, right?

>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  include/hw/boards.h | 1 -
>>  vl.c                | 4 ++--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 21212f0859..e911d56c28 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -57,7 +57,6 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>>  #define MACHINE_CLASS(klass) \
>>      OBJECT_CLASS_CHECK(MachineClass, (klass), TYPE_MACHINE)
>>  
>> -MachineClass *find_default_machine(void);
>>  extern MachineState *current_machine;
>>  
>>  void machine_run_board_init(MachineState *machine);
>> diff --git a/vl.c b/vl.c
>> index 502857a176..3688e2bc98 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1441,7 +1441,7 @@ static MachineClass *find_machine(const char *name)
>>      return mc;
>>  }
>>  
>> -MachineClass *find_default_machine(void)
>> +static MachineClass *find_default_machine(void)
>>  {
>>      GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
>>      MachineClass *mc = NULL;
>> @@ -2538,7 +2538,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>>                    object_class_get_name(OBJECT_CLASS(mc1)));
>>  }
>>  
>> - static MachineClass *machine_parse(const char *name)
>> +static MachineClass *machine_parse(const char *name)
>>  {
>>      MachineClass *mc = NULL;
>>      GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
>
>Not related to this patch's stated purpose.  Should go into PATCH 2,
>where you're changing this line anyway.

-- 
Wei Yang
Help you, Help me
