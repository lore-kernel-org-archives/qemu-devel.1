Received: from eggs.gnu.org ([2001:4830:134:3::10]:49426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daqy5-000662-Du
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daqy4-000827-6v
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:09:17 -0400
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
From: John Snow <jsnow@redhat.com>
Message-ID: <11af0732-e024-6651-5b65-07eb98d8bb17@redhat.com>
Date: Thu, 27 Jul 2017 18:09:04 -0400
MIME-Version: 1.0
In-Reply-To: <20170726182320.cnqx3y64c7nmhvp3@postretch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Jeff Cody <jcody@redhat.com>



On 07/26/2017 02:23 PM, Manos Pitsidianakis wrote:
> On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
>> On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
>>> This proposal follows a discussion we had with Kevin and Stefan on 
>>> filter
>>> node management.
>>>
>>> With block filter drivers arises a need to configure filter nodes on 
>>> runtime
>>> with QMP on live graphs. A problem with doing live graph 
>>> modifications is
>>> that some block jobs modify the graph when they are done and don't 
>>> operate
>>> under any synchronisation, resulting in a race condition if we try to 
>>> insert
>>> a filter node in the place of an existing edge.
>>
>> But maybe you are thinking about higher level race conditions between
>> QMP commands.  Can you give an example of the race?
> 
> Exactly, synchronisation between the QMP/user actions. Here's an 
> example, correct me if I'm wrong:
> 
> User issues a block-commit to this tree to commit A onto B:
>     BB -> A -> B
> 
> This inserts the dummy mirror node at the top since this is a mirror job 
> (active commit)
>     BB -> dummy -> A -> B
> 
> User wants to add a filter node F below the BB. First we create the node:
>     BB -> dummy -> A -> B
>        F /
> 
> Commit finishes before we do block-insert-node, dummy and A is removed 
> from the BB's chain, mirror_exit calls bdrv_replace_node()
> 
>     BB ------------> B
>                 F -> /
> 
> Now inserting F under BB will error since dummy does not exist any more.
> 

Exactly how much of a problem is this? You, the user, have instructed 
QEMU to do two conflicting things:

(1) Squash A down into B, and
(2) Insert a filter above A

Shame on you for deleting the node you were trying to reference, no? And 
as an added bonus, QEMU will even error out on your command instead of 
trying to do something and getting it wrong.

Is this a problem?

> The proposal doesn't guard against the following:
> User issues a block-commit to this tree to commit B onto C:
>     BB -> A -> B -> C
> 
> The dummy node (commit's top bs is A):
>     BB -> A -> dummy -> B -> C
> 
> blockdev-add of a filter we wish to eventually be between A and C:
>     BB -> A -> dummy -> B -> C
>              F/
> 
> if commit finishes before we issue block-insert-node (commit_complete()
> calls bdrv_set_backing_hd() which only touches A)
>     BB -> A --------------> C
>            F -> dummy -> B /
>     resulting in error when issuing block-insert-node,

Because "B" and "dummy" have already actually been deleted, I assume. 
(The diagram is confusing.)

> 
> else if we set the job to manual-delete and insert F:
>     BB -> A -> F -> dummy -> B -> C
> deleting the job will result in F being lost since the job's top bs 
> wasn't updated.
> 

Seems like a fairly good reason not to pursue this avenue then, yes?

I think I agree with Stefan's concerns that this is more of a temporary 
workaround for the benefit of jobs, but that there may well be other 
reasons (especially in the future) where graph manipulations may occur 
invisibly to the user.

Do you have any use cases for failure here that don't involve the user 
themselves asking for two conflicting things? That is, QEMU doing some 
graph reorganization without the user's knowledge coupled with the user 
asking for a new filter node?

Are there any failures that result in anything more dangerous or bad 
than a "404: node not found" style error where we simply reject the 
premise of what the user was attempting to accomplish?
