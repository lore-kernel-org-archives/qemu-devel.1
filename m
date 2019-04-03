Received: from eggs.gnu.org ([209.51.188.92]:45158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBZBI-0006wa-M3
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 02:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBZBH-00088Z-GD
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 02:15:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBZBH-0007yh-7F
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 02:15:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190311060823.18360-3-richardw.yang@linux.intel.com>
	<87a7h8bkof.fsf@dusky.pond.sub.org>
	<20190402151630.pdmwljy7d6fkcu3u@master>
	<875zrw8k28.fsf@dusky.pond.sub.org> <20190403004907.GA18346@richard>
Date: Wed, 03 Apr 2019 08:15:18 +0200
In-Reply-To: <20190403004907.GA18346@richard> (Wei Yang's message of "Wed, 3
	Apr 2019 08:49:07 +0800")
Message-ID: <87ftqz4nt5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] vl.c: allocate TYPE_MACHINE list once
 during bootup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, Wei Yang <richard.weiyang@gmail.com>

Wei Yang <richardw.yang@linux.intel.com> writes:

> On Tue, Apr 02, 2019 at 06:10:23PM +0200, Markus Armbruster wrote:
>>Wei Yang <richard.weiyang@gmail.com> writes:
>
> [...]
>
>>>>>  
>>>>> @@ -2659,7 +2655,8 @@ static const QEMUOption *lookup_opt(int argc, char **argv,
>>>>>  
>>>>>  static MachineClass *select_machine(void)
>>>>>  {
>>>>> -    MachineClass *machine_class = find_default_machine();
>>>>> +    GSList *machines = object_class_get_list(TYPE_MACHINE, false);
>>>>> +    MachineClass *machine_class = find_default_machine(machines);
>>>>>      const char *optarg;
>>>>>      QemuOpts *opts;
>>>>>      Location loc;
>>>>> @@ -2671,7 +2668,7 @@ static MachineClass *select_machine(void)
>>>>>  
>>>>>      optarg = qemu_opt_get(opts, "type");
>>>>>      if (optarg) {
>>>>> -        machine_class = machine_parse(optarg);
>>>>> +        machine_class = machine_parse(optarg, machines);
>>>>
>>>>Could create and destroy @machines here:
>>>>
>>>>  -        machine_class = machine_parse(optarg);
>>>>  +        GSList *machines = object_class_get_list(TYPE_MACHINE, false);
>>>>  +        machine_class = machine_parse(optarg, machines);
>>>>  +        g_slist_free(machines);
>>>>
>>>>Matter of taste.
>>
>>[*]
>>
>>Matter of taste means the choice between your version and mine is up to
>>the maintainer, or if the maintainer remains silent, up to you.
>>
>
> Ok, I get your meaning.
>
> But machines should be used in find_default_machine(), after move the
> allocation in "if", would there be a problem?
>
> I may not understand your point here.

You're right, I overlooked that use of @machines.  Keep your patch as it
is.
