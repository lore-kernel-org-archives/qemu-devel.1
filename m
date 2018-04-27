Received: from eggs.gnu.org ([2001:4830:134:3::10]:48770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBwvO-0004Sq-SS
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBwvN-00079N-Vx
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:32:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
Date: Fri, 27 Apr 2018 08:31:58 +0200
In-Reply-To: <20180427003215.GU29865@localhost.localdomain> (Eduardo Habkost's
	message of "Thu, 26 Apr 2018 21:32:15 -0300")
Message-ID: <87o9i5uplt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test devices
 with all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, Apr 26, 2018 at 05:20:25PM +0200, Thomas Huth wrote:
>> On 26.04.2018 13:45, Markus Armbruster wrote:
>> > Thomas Huth <thuth@redhat.com> writes:
>> [...]
>> >> @@ -260,6 +263,26 @@ static void test_abstract_interfaces(void)
>> >>      qtest_end();
>> >>  }
>> >>  
>> >> +static void add_machine_test_case(const char *mname)
>> >> +{
>> >> +    char *path, *args;
>> >> +
>> >> +    /* Ignore blacklisted machines */
>> >> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname)) {
>> >> +        return;
>> >> +    }
>> >> +
>> >> +    path = g_strdup_printf("device/introspect/concrete-defaults-%s", mname);
>> >> +    args = g_strdup_printf("-machine %s", mname);
>> >> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>> > 
>> > This runs test_device_intro_concrete() with "-machine M" for all machine
>> > types M, in SPEED=slow mode.
>> > 
>> >> +    g_free(path);
>> >> +
>> >> +    path = g_strdup_printf("device/introspect/concrete-nodefaults-%s", mname);
>> >> +    args = g_strdup_printf("-nodefaults -machine %s", mname);
>> >> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>> > 
>> > This runs test_device_intro_concrete() with "-nodefaults -machine M" for
>> > all machine types M, in SPEED=slow mode.
>> > 
>> > Has "without -nodefaults" exposed additional bugs?
>> 
>> After testing this with all machines, I had to discover that
>> "-nodefaults" does not work so easily: A lot of the embedded machines
>> (especially the ARM machines) simply refuse to work with "-nodefaults"
>> and exit immediately instead. E.g.:
>> 
>> $ arm-softmmu/qemu-system-arm -nodefaults -nographic -M n810,accel=qtest
>> qemu-system-arm: missing SecureDigital device

These are all bugs.  --nodefaults is supposed to suppress *optional*
devices, not mandatory ones.

>> So we'd either need a rather big black list for the machines that do not
>> work, or simply drop the "-nodefaults" tests from this patch.
>
> Or we could try to test all machines anyway, but not consider it
> an error if QEMU just does exit(1).  Can the qtest C API give us
> that information?
>
> (Or we could simply let -nodefaults aside by now, and do this
> after we implement this test case in Python.)

Or we could fix the bugs.
