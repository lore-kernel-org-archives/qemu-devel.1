Received: from eggs.gnu.org ([2001:4830:134:3::10]:37566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYWeA-0004wm-Uu
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYWe9-0001m7-Ll
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:30:50 -0500
MIME-Version: 1.0
In-Reply-To: <b3cd5e07-6120-0540-cd77-5a0562270bb2@redhat.com>
References: <20170128035929.10168-1-nirsof@gmail.com>
	<b3cd5e07-6120-0540-cd77-5a0562270bb2@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Tue, 31 Jan 2017 13:30:42 +0200
Message-ID: <CAMr-obs0X=3JjcMhsUsnzddfsUqZHcKdPu-tBBxDLW32pQ-bEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu-io: Return non-zero exit code
 on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>

On Mon, Jan 30, 2017 at 6:44 PM, Eric Blake <eblake@redhat.com> wrote:
> On 01/27/2017 09:59 PM, Nir Soffer wrote:
>> From: Nir Soffer <nsoffer@redhat.com>
>>
>> The result of openfile was not checked, leading to failure deep in the
>> actual command with confusing error message, and exiting with exit code 0.
>>
>
> When posting a series, please ensure that your messages are all marked
> In-Reply-To a 0/3 cover letter (it may help if you do 'git config
> format.coverletter auto').
>
>> Here is a simple example - trying to read with the wrong format:
>>
>>     $ touch file
>>     $ qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
>>     can't open device file: Image is not in qcow2 format
>>     no file open, try 'help open'
>>     0
>>
>> With this patch, we fail earlier with exit code 1:
>>
>>     $ ./qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
>>     can't open device file: Image is not in qcow2 format
>>     1
>>
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>
>> Changes since v2:
>> - Adding missing signed-off-by
>> - Fix tests expecting the wrong output
>
> I don't see any tests changed...
>
>>
>>  qemu-io.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> ...in this diffstat.  If something really changed in this particular
> patch since v2, then you should drop the Reviewed-by lines in order to
> make sure I re-review it.  Or, if the changes you mention here are to
> other patches in the series, then the 0/3 cover letter would have been a
> better place to put that information.

This diffstat is a poor man cover letter,  I'll resend a proper one.

>
>>
>> diff --git a/qemu-io.c b/qemu-io.c
>> index 23a229f..427cbae 100644
>> --- a/qemu-io.c
>> +++ b/qemu-io.c
>> @@ -595,13 +595,17 @@ int main(int argc, char **argv)
>>                  exit(1);
>>              }
>>              opts = qemu_opts_to_qdict(qopts, NULL);
>> -            openfile(NULL, flags, writethrough, opts);
>> +            if (openfile(NULL, flags, writethrough, opts)) {
>> +                exit(1);
>> +            }
>>          } else {
>>              if (format) {
>>                  opts = qdict_new();
>>                  qdict_put(opts, "driver", qstring_from_str(format));
>>              }
>> -            openfile(argv[optind], flags, writethrough, opts);
>> +            if (openfile(argv[optind], flags, writethrough, opts)) {
>> +                exit(1);
>> +            }
>>          }
>>      }
>>      command_loop();
>>
>
> At any rate, I'm happy with this current patch, even if its presentation
> in a series is less than ideal, so you can keep my R-b.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
