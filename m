Received: from eggs.gnu.org ([2001:4830:134:3::10]:41702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdMh-0004KL-P4
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdMO-0007bk-GY
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:44:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpdMO-0007bA-9N
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:44:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm> <20180814141826.GA26558@ruderich.org>
Date: Tue, 14 Aug 2018 17:49:12 +0200
In-Reply-To: <20180814141826.GA26558@ruderich.org> (Simon Ruderich's message
	of "Tue, 14 Aug 2018 16:18:26 +0200")
Message-ID: <871sb1t0cn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Simon Ruderich <simon@ruderich.org> writes:

> On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
>>> --- a/hmp-commands.hx
>>> +++ b/hmp-commands.hx

Subject claims "qmp: add", but the patch also adds to hmp.  Recommend to
split the patch into QMP and HMP part.

>>> @@ -822,6 +822,20 @@ STEXI
>>>  @item pmemsave @var{addr} @var{size} @var{file}
>>>  @findex pmemsave
>>>  save to disk physical memory dump starting at @var{addr} of size @var{size}.
>>> +ETEXI
>>> +
>>> +    {
>>> +        .name       = "pmemload",
>>> +        .args_type  = "val:l,size:i,offset:i,filename:s",
>>> +        .params     = "addr size offset file",
>>> +        .help       = "load from disk physical memory dump starting at 'addr' of size 'size' at file offset 'offset'",
>>> +        .cmd        = hmp_pmemload,
>>> +    },
>>> +
>>
>> I'm guessing that size and offset should be 'l' to allow large
>> sizes and offsets, and there's an 'F' type for filenames
>
> I've copied that from "pmemsave" and "memsave" which use 'i' for
> size. I'll add patches which will adapt them to use both 'l' and
> 'F' and adapt my pmemload patch as well.
>
> qapi/misc.json seems to always use 'int' for integer types. Is
> this value large enough on 64-bit architectures?

Yes.  QAPI's int translates to int64_t.

>> (see monitor.c which has a big comment table near the start).
>
> Thanks.
>
> Just curious, what is the difference between 's' and 'F'. Is that
> only for documentation purposes (and maybe tab completion) or is
> the usage different? I noticed existing code uses qdict_get_str()
> for both 's' and 'F'.

The main behavioral difference is completion.

>> Also, had you considered rearranging and making them optional,
>> for example if you do:
>>
>> val:l,filename:F,offset:i?,size:i?
>>
>> I think that would mean you can do the fairly obvious:
>>   pmemload addr "myfile"
>>
>> with the assumption that loads the whole file.
>
> I tried to keep it as similar to the existing functions
> "memsave"/"pmemsave", only adding "offset". Eric Blake already
> raised this issue in the thread, here's my response for
> reference:
>
> On Mon, Apr 23, 2018 at 02:46:57PM -0500, Eric Blake wrote:
>> Back-compat in the QMP interface matters.  The HMP interface, however,
>> exists to serve humans not machines, and we can break it at will to
>> something that makes more sense to humans.  So don't let HMP concerns
>> hold you back from a sane interface.
>
> I see. However I don't like breaking existing interfaces unless I
> have to. In this case I think not having the optional parameters
> is fine and the consistency between the existing memsave/pmemsave
> functions is more important.
>
>> Optional parameters are listed as '*name':'type' in the .json file,
>> which tells the generator to create a 'has_name' bool parameter
>> alongside the 'name' parameter in the C code for the QMP interface.  The
>> HMP interface should then call into the QMP interface.
>>
>> Recent HMP patches that I've authored may offer some inspiration: commit
>> 08fb10a added a new command, and commit dba4932 added an optional
>> parameter to an existing command.
>
> Thank you for the explanation, this looks straight-forward.
>
> Do you have strong opinions regarding the optional parameters or
> would you accept the patch as is (minus possible implementation
> issues)? I like the symmetry to the existing functions (I noticed
> that size can only be optional for pmemload because saving the
> complete memory doesn't sound useful) and having to specify
> size/offset doesn't hurt the caller too much.

I recommend to start with the QMP interface.  Parameters are unordered
there.  memsave and pmemsave both take mandatory @val, @size, @filename.
memsave additionally takes optional @cpu-index.

Your pmemload has pmemsave's arguments plus and mandatory @offset.
Rationale for adding @offset?  You may have answered this question
already; pointer to that answer would be fine.

Once we got the QMP interface nailed down, we can move to the HMP
interface.

> Thanks for your review!
>
> Regards
> Simon
>
> PS: Diff between v3 and my current local version follows:
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 5a43dae133..c39d745a22 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -818,7 +818,7 @@ ETEXI
>  
>      {
>          .name       = "memsave",
> -        .args_type  = "val:l,size:i,filename:s",
> +        .args_type  = "val:l,size:l,filename:F",
>          .params     = "addr size file",
>          .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_memsave,
> @@ -832,7 +832,7 @@ ETEXI
>  
>      {
>          .name       = "pmemsave",
> -        .args_type  = "val:l,size:i,filename:s",
> +        .args_type  = "val:l,size:l,filename:F",
>          .params     = "addr size file",
>          .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_pmemsave,

These two should become a separate bug fix patch.  The bug being fixed
is completion.

> @@ -846,7 +846,7 @@ ETEXI
>  
>      {
>          .name       = "pmemload",
> -        .args_type  = "val:l,size:i,offset:i,filename:s",
> +        .args_type  = "val:l,size:l,offset:l,filename:F",
>          .params     = "addr size offset file",
>          .help       = "load from disk physical memory dump starting at 'addr' of size 'size' at file offset 'offset'",
>          .cmd        = hmp_pmemload,
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 6c34b2ff8b..becc257a76 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1196,7 +1196,7 @@
>  #
>  # Returns: Nothing on success
>  #
> -# Since: 2.13
> +# Since: 3.1
>  ##
>  { 'command': 'pmemload',
>    'data': {'val': 'int', 'size': 'int', 'offset': 'int', 'filename': 'str'} }
