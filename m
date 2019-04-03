Received: from eggs.gnu.org ([209.51.188.92]:50032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBU5u-0004CR-9v
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 20:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBU5t-0005Ln-Dx
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 20:49:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:61909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hBU5s-0005I4-TU
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 20:49:33 -0400
Date: Wed, 3 Apr 2019 08:49:07 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190403004907.GA18346@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190311060823.18360-3-richardw.yang@linux.intel.com>
	<87a7h8bkof.fsf@dusky.pond.sub.org>
	<20190402151630.pdmwljy7d6fkcu3u@master>
	<875zrw8k28.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zrw8k28.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>, ehabkost@redhat.com, qemu-devel@nongnu.org

On Tue, Apr 02, 2019 at 06:10:23PM +0200, Markus Armbruster wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:

[...]

>>>>  
>>>> @@ -2659,7 +2655,8 @@ static const QEMUOption *lookup_opt(int argc, char **argv,
>>>>  
>>>>  static MachineClass *select_machine(void)
>>>>  {
>>>> -    MachineClass *machine_class = find_default_machine();
>>>> +    GSList *machines = object_class_get_list(TYPE_MACHINE, false);
>>>> +    MachineClass *machine_class = find_default_machine(machines);
>>>>      const char *optarg;
>>>>      QemuOpts *opts;
>>>>      Location loc;
>>>> @@ -2671,7 +2668,7 @@ static MachineClass *select_machine(void)
>>>>  
>>>>      optarg = qemu_opt_get(opts, "type");
>>>>      if (optarg) {
>>>> -        machine_class = machine_parse(optarg);
>>>> +        machine_class = machine_parse(optarg, machines);
>>>
>>>Could create and destroy @machines here:
>>>
>>>  -        machine_class = machine_parse(optarg);
>>>  +        GSList *machines = object_class_get_list(TYPE_MACHINE, false);
>>>  +        machine_class = machine_parse(optarg, machines);
>>>  +        g_slist_free(machines);
>>>
>>>Matter of taste.
>
>[*]
>
>Matter of taste means the choice between your version and mine is up to
>the maintainer, or if the maintainer remains silent, up to you.
>

Ok, I get your meaning.

But machines should be used in find_default_machine(), after move the
allocation in "if", would there be a problem?

I may not understand your point here.

-- 
Wei Yang
Help you, Help me
