Received: from eggs.gnu.org ([2001:4830:134:3::10]:50271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCnJ2-0008Qz-3X
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCnIv-0001CV-QI
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:23:28 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCnIv-0001Bw-Ki
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:23:21 -0400
Received: by mail-oi0-x22c.google.com with SMTP id w10so161063349oif.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:23:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-4-f4bug@amsat.org> <87mva5497m.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39794bd4-b387-7431-1f25-a70af6013c42@amsat.org>
Date: Mon, 22 May 2017 10:23:18 -0300
MIME-Version: 1.0
In-Reply-To: <87mva5497m.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/24] docker: rebuild image if 'extra
 files' checksum does not match
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

Hi Alex,

On 05/22/2017 04:55 AM, Alex Bennée wrote:
>
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/docker.py | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> Hmm odd what bracnh did you cut this from. git apply-mbox keeps falling
> over:
>
> Applying: docker: rebuild image if 'extra files' checksum does not match
> error: sha1 information is lacking or useless (tests/docker/docker.py).
> error: could not build fake ancestor
> Patch failed at 0001 docker: rebuild image if 'extra files' checksum does not match
> The copy of the patch that failed is found in: .git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

Weird...

I still have the command in my history, I used:
   $ git format-patch master --cover-letter -v 3 -n -s -o 
outgoing/shippable_v3 --to qemu-devel@nongnu.org --to 'Alex Bennée 
<alex.bennee@linaro.org>' --to 'Fam Zheng <famz@redhat.com>'

Having:
   $ git rev-parse master
56821559f0ba682fe6b367815572e6f974d329ab

You can also fetch this branch here:
   https://github.com/philmd/qemu/tree/docker_shippable_v3
Shippable output:
   https://app.shippable.com/github/philmd/qemu/status/dashboard

Regards,

Phil.

>
>
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index eef92a54f1..0dd6a3304f 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -38,6 +38,9 @@ def _text_checksum(text):
>>      """Calculate a digest string unique to the text content"""
>>      return hashlib.sha1(text).hexdigest()
>>
>> +def _file_checksum(filename):
>> +    return _text_checksum(open(filename, 'rb').read())
>> +
>>  def _guess_docker_command():
>>      """ Guess a working docker command or raise exception if not found"""
>>      commands = [["docker"], ["sudo", "-n", "docker"]]
>> @@ -154,7 +157,7 @@ class Docker(object):
>>          return labels.get("com.qemu.dockerfile-checksum", "")
>>
>>      def build_image(self, tag, docker_dir, dockerfile,
>> -                    quiet=True, user=False, argv=None):
>> +                    quiet=True, user=False, argv=None, extra_files_cksum=[]):
>>          if argv == None:
>>              argv = []
>>
>> @@ -170,7 +173,7 @@ class Docker(object):
>>
>>          tmp_df.write("\n")
>>          tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" %
>> -                     _text_checksum(dockerfile))
>> +                     _text_checksum(dockerfile + "-".join(extra_files_cksum)))
>>          tmp_df.flush()
>>
>>          self._do(["build", "-t", tag, "-f", tmp_df.name] + argv + \
>> @@ -276,16 +279,22 @@ class BuildCommand(SubCommand):
>>                      return 1
>>
>>              # Include files used by ADD directives found within the Dockerfile.
>> +            cksum = []
>>              if args.include_executable:
>> +                # FIXME: there is no checksum of this executable and the linked
>> +                # libraries, once the image built any change of this executable
>> +                # or any library won't trigger another build.
>>                  _copy_binary_with_libs(args.include_executable, docker_dir)
>>              for filename in args.include_files or []:
>>                  _copy_with_mkdir(filename, docker_dir)
>> +                cksum += [_file_checksum(filename)]
>>
>>              argv += ["--build-arg=" + k.lower() + "=" + v
>>                          for k, v in os.environ.iteritems()
>>                          if k.lower() in FILTERED_ENV_NAMES]
>>              dkr.build_image(tag, docker_dir, dockerfile,
>> -                            quiet=args.quiet, user=args.user, argv=argv)
>> +                            quiet=args.quiet, user=args.user, argv=argv,
>> +                            extra_files_cksum=cksum)
>>
>>              rmtree(docker_dir)
>
>
> --
> Alex Bennée
>
