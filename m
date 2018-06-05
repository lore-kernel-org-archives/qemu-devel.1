Received: from eggs.gnu.org ([2001:4830:134:3::10]:47911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQDCz-0000jA-1J
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQDCv-0008Co-D1
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:45:12 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQDCv-0008BT-65
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:45:09 -0400
Received: by mail-qt0-x244.google.com with SMTP id i18-v6so2635005qtp.12
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:45:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530200334.24179-1-f4bug@amsat.org>
	<22ca41bb-9f8b-e8bb-e676-b5c96f3f9add@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <acf7522a-4fc0-5138-9797-6cfcc5ad5719@amsat.org>
Date: Tue, 5 Jun 2018 11:45:03 -0300
MIME-Version: 1.0
In-Reply-To: <22ca41bb-9f8b-e8bb-e676-b5c96f3f9add@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] configure: Enable out-of-tree
 acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Amador Pahim <amador@pahim.org>
Cc: qemu-devel@nongnu.org

On 05/30/2018 10:06 PM, Cleber Rosa wrote:
> On 05/30/2018 04:03 PM, Philippe Mathieu-Daudé wrote:
>> In order to allow out-of-tree acceptance tests with Avocado,
>> create a symlink in the build tree.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Based-on: 20180530184156.15634-1-crosa@redhat.com
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06877.html
>>
>> Before:
>>
>>   build_dir$ avocado run /full/path/to/sources/qemu/tests/acceptance/boot_linux_console.py
>>
>> After
>>
>>   build_dir$ avocado run tests/acceptance/boot_linux_console.py
>>
>> I first wanted to try something like:
>>
>> echo "[datadir.paths]" > .avocado.conf
>> echo "test_dir = $source_path/tests/acceptance" >> .avocado.conf
>>
> 
> FIY, "$HOME/.config/avocado/avocado.conf" is parsed by default.  Take a
> look at the "avocado config" output for the details.

I followed the virtualenv installation from the link you added in
testing.rst:
http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado

So my config is:

Config files read (in order):

/builds/qemu/venv2/local/lib/python2.7/site-packages/avocado/etc/avocado/avocado.conf

/builds/qemu/venv2/local/lib/python2.7/site-packages/avocado/etc/avocado/conf.d/result_upload.conf

/builds/qemu/venv2/local/lib/python2.7/site-packages/avocado/etc/avocado/conf.d/resultsdb.conf

/builds/qemu/venv2/local/lib/python2.7/site-packages/avocado/etc/avocado/conf.d/jobscripts.conf

/builds/qemu/venv2/local/lib/python2.7/site-packages/avocado/etc/avocado/conf.d/gdb.conf

    Section.Key                              Value
    datadir.paths.base_dir                   /var/lib/avocado
    datadir.paths.test_dir                   /usr/share/avocado/tests
    datadir.paths.data_dir                   /var/lib/avocado/data
    datadir.paths.logs_dir                   ~/avocado/job-results

I find useful to be able to append/overwrite the user 'global' config
with a current directory one, like we have with .gdbinit, because I use
out-of-tree build dir to test different build options/features with the
same codebase.

So personally I'd like this parse order:

- $VENV/lib/python2.7/site-packages/avocado/etc/avocado/avocado.conf
- $HOME/.config/avocado/avocado.conf
- .avocado.conf

> 
>> to run:
>>
>>   build_dir$ avocado run -t console
>>
> 
> I see your point, you'd like the command above to behave similarly to:
> 
>   avocado run -t console $avocado_datadir_paths_test_dir
> 
> Right?  So, the first compromise solution with current Avocado is:
> 
>   echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
>   echo "test_dir = $source_path/tests/acceptance" >>
> ~/.config/avocado/avocado.conf
> 
> With "$source_path" being something literal, and not a variable.  It
> allows individual tests to be found at that location:
> 
>   cd /some/random/path
>   avocado run boot_linux_console.py

'echo' is not that friendly :S

$ avocado run boot_linux_console.py
Avocado crashed unexpectedly: Value 'logs_dir' not found in section
'datadir.paths'
You can find details in
/var/tmp/avocado-traceback-2018-06-05_11:32:01-MUn_kE.log

> 
> But the following still won't work:
> 
>   avocado run -t console
>   No test references provided nor any other arguments resolved into
> tests. Please double check the executed command.
> 
> I do think the current Avocado behavior is somewhat inconsistent,
> because list and run should ideally be symmetrical.  With the
> configuration above, "list" behaves like this:
> 
>    avocado list
> INSTRUMENTED
> /home/cleber/src/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test
> INSTRUMENTED
> /home/cleber/src/qemu/tests/acceptance/version.py:Version.test_qmp_human_info_version
> INSTRUMENTED /home/cleber/src/qemu/tests/acceptance/vnc.py:Vnc.test_no_vnc
> INSTRUMENTED
> /home/cleber/src/qemu/tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password
> INSTRUMENTED
> /home/cleber/src/qemu/tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_password
> INSTRUMENTED
> /home/cleber/src/qemu/tests/acceptance/vnc.py:Vnc.test_vnc_change_password
> 
> But at the same, there are security implications: `list` won't
> load/execute any test code (different from, say, standard Python
> unittests), while "run" obviously will.  So "avocado run" may end up
> running what users don't want if a malicious user controls
> "$avocado_datadir_paths_test_dir".
> 
> What if Avocado introduces an option that would enable the use of
> Avocado's test dir when no test reference is given?  This could be
> enabled only once (but would be disabled by default):
> 
>   echo "[loader]" > ~/.config/avocado/avocado.conf
>   echo "use_test_dir_when_no_references_given = True" >> >
> ~/.config/avocado/avocado.conf
> 
>   echo "[datadir.paths]" >> ~/.config/avocado/avocado.conf
>   echo "test_dir = $source_path/tests/acceptance" >>
> ~/.config/avocado/avocado.conf
> 
> And after that, the following would run all "console" tests:
> 
>   avocado run -t console
> 
> How does this sound?

For my use cases this doesn't worry me, I'll let Eduardo/Fam opine about
use_test_dir_when_no_references_given.

> 
> - Cleber.
> 
>> but this doesn't work this way, I'd have to use
>>
>>   build_dir$ avocado --config .avocado.conf boot_linux_console.py -t console
>>
>> which isn't a win.
>> ---
>>  configure | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/configure b/configure
>> index a6a4616c3e..0763ebe5ba 100755
>> --- a/configure
>> +++ b/configure
>> @@ -7213,9 +7213,11 @@ for rom in seabios vgabios ; do
>>  done
>>  
>>  # set up tests data directory
>> -if [ ! -e tests/data ]; then
>> -    symlink "$source_path/tests/data" tests/data
>> -fi
>> +for tests_subdir in acceptance data; do
>> +    if [ ! -e tests/$tests_subdir ]; then
>> +        symlink "$source_path/tests/$tests_subdir" tests/$tests_subdir
>> +    fi
>> +done
>>  
>>  # set up qemu-iotests in this build directory
>>  iotests_common_env="tests/qemu-iotests/common.env"
>>
