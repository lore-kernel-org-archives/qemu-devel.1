Received: from eggs.gnu.org ([2001:4830:134:3::10]:46507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCT6E-0007AI-Uj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCT6C-0000QK-Hf
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:10 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171030181459.1951-1-f4bug@amsat.org>
	<20171103003520.GF3111@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9adefce7-1c65-9539-1961-fa981f0ecccc@amsat.org>
Date: Wed, 8 Nov 2017 13:20:49 -0300
MIME-Version: 1.0
In-Reply-To: <20171103003520.GF3111@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/02/2017 09:35 PM, Eduardo Habkost wrote:
> On Mon, Oct 30, 2017 at 03:14:59PM -0300, Philippe Mathieu-Daudé wrote:
>> examples configuring with '--enable-kvm --disable-tcg'
>>
>> - before
>>
>>   $ qemu-system-x86_64 -accel help
>>   Possible accelerators: kvm, xen, hax, tcg
>>
>>   $ qemu-system-x86_64 -accel tcg
>>   qemu-system-x86_64: -machine accel=tcg: No accelerator found
>>
>>   # qemu-system-x86_64 -accel hax
>>   qemu-system-x86_64: -machine accel=hax: No accelerator found
>>
>> - after
>>
>>   $ qemu-system-x86_64 -accel help
>>   Possible accelerators:
>>     xen
>>     kvm
>>
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> since RFC:
>>   - use much cleaner object_class_get_list(TYPE_ACCEL, false)
>>
>>  vl.c | 39 ++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index ec299099ff..0f13641715 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2764,6 +2764,39 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>>      exit(!name || !is_help_option(name));
>>  }
>>  
>> +static void accel_list_entry(gpointer data, gpointer user_data)
>> +{
>> +    ObjectClass *oc = data;
>> +    const char *typename = object_class_get_name(oc);
>> +    int len;
>> +
>> +    if (!qtest_driver() && !g_strcmp0(typename, ACCEL_CLASS_NAME("qtest"))) {
>> +        return; /* used by test cases */
>> +    }
> 
> I would prefer to not hardcode the accel name here.  If you want
> qtest to have special behavior, you can add a new field to
> AccelClass to implement that.
> 
> However, I don't think I agree we should hide qtest from the
> user: it is accepted on the command-line, so why should we lie?

Ok.

> Why not add a description field and indicate that qtest is useful
> only for testing?

This is cleaner indeed.

>> +
>> +    len = strlen(typename) - strlen("-" TYPE_ACCEL);
> 
> You can use AccelClass::name here.

Hmm yes but currently this is not what the user should use, since the
accel_find() matches the ACCEL_CLASS_NAME:

$ ppc64-softmmu/qemu-system-ppc64 -accel QTest
qemu-system-ppc64: -machine accel=QTest: No accelerator found

I'll respin but the change will be bigger so I is probably too late for
2.11.

> 
>> +    if (len > 0) {
>> +        error_printf("  %.*s\n", len, typename);
>> +    }
>> +}
>> +
>> +static void accel_parse(const char *name, QemuOpts *accel_opts)
>> +{
>> +    const char *optarg = qemu_opt_get(accel_opts, "accel");
>> +    GSList *list;
>> +
>> +    if (!is_help_option(optarg)) {
>> +        return;
>> +    }
>> +
>> +    list = object_class_get_list(TYPE_ACCEL, false);
>> +    error_printf("Possible accelerators:\n");
>> +    g_slist_foreach(list, accel_list_entry, NULL);
>> +    g_slist_free(list);
>> +
>> +    exit(0);
>> +}
>> +
>>  void qemu_add_exit_notifier(Notifier *notify)
>>  {
>>      notifier_list_add(&exit_notifiers, notify);
>> @@ -3881,11 +3914,7 @@ int main(int argc, char **argv, char **envp)
>>              case QEMU_OPTION_accel:
>>                  accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
>>                                                       optarg, true);
>> -                optarg = qemu_opt_get(accel_opts, "accel");
>> -                if (!optarg || is_help_option(optarg)) {
>> -                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
>> -                    exit(0);
>> -                }
>> +                accel_parse(optarg, accel_opts);
>>                  opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
>>                                          false, &error_abort);
>>                  qemu_opt_set(opts, "accel", optarg, &error_abort);
>> -- 
>> 2.15.0.rc2
>>
> 
