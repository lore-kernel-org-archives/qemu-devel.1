Received: from eggs.gnu.org ([2001:4830:134:3::10]:49391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cRas5-0000B7-FA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cRas0-0001ID-Tm
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:36:33 -0500
References: <1484167250-16089-1-git-send-email-thuth@redhat.com>
	<87tw94em1e.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ad4e2d18-4cef-9df1-3d85-4749cf000175@redhat.com>
Date: Thu, 12 Jan 2017 09:36:25 +0100
MIME-Version: 1.0
In-Reply-To: <87tw94em1e.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: Fix crashes when using HMP
 commands without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org

On 12.01.2017 09:10, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> When running certain HMP commands ("info registers", "info cpustats"
>> or dumping virtual memory) with the "none" machine, QEMU crashes
>> with a segmentation fault. This happens because the "none" machine doe=
s
>> not have any CPUs by default,
>=20
> "Sachen gibt's!"
>=20
>>                               but these HMP commands did not check for
>> a valid CPU pointer yet. Add such a check now and print a message
>> about the missing CPU instead.
>=20
> Have you checked uses of first_cpu elsewhere?  Out of scope for this
> patch, of course.

I only looked at monitor.c so far, and that's the only spot that uses
this variable there.

But it seems like gdbstub.c has the same bug, too. If I start the "none"
machine and attach a remote gdb, QEMU segfaults here, too.
I've put this on my TODO-list... (I think it should be fixed with a
separate patch).

>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  monitor.c | 29 +++++++++++++++++++++++++----
>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 0841d43..0103979 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1025,6 +1025,9 @@ int monitor_set_cpu(int cpu_index)
>>  CPUState *mon_get_cpu(void)
>>  {
>>      if (!cur_mon->mon_cpu) {
>> +        if (!first_cpu) {
>> +            return NULL;
>> +        }
>>          monitor_set_cpu(first_cpu->cpu_index);
>>      }
>>      cpu_synchronize_state(cur_mon->mon_cpu);
>=20
> Why are the following dereferences safe?
>=20
>    CPUArchState *mon_get_cpu_env(void)
>    {
>        return mon_get_cpu()->env_ptr;
>    }
>=20
>    int monitor_get_cpu_index(void)
>    {
>        return mon_get_cpu()->cpu_index;
>    }

Oh, they are apparently not safe either. The HMP commands "nmi" and
"memsave", which use these functions, are crashing on the "none"
machine, too... I'll send a v2 of my patch to fix these, too ...

Thanks for the review!

 Thomas
