Received: from eggs.gnu.org ([2001:4830:134:3::10]:53662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqm6R-0004NF-J9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqm6Q-0004bs-KK
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:43:59 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-13-jsnow@redhat.com>
	<6145ae58-a0e7-6262-e679-480936cda576@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <422b1804-42ba-d233-b683-eb621f047fc2@redhat.com>
Date: Tue, 27 Feb 2018 15:43:53 -0500
MIME-Version: 1.0
In-Reply-To: <6145ae58-a0e7-6262-e679-480936cda576@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 12/21] blockjobs: ensure abort is called
 for cancelled jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/27/2018 02:49 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> Presently, even if a job is canceled post-completion as a result of
>> a failing peer in a transaction, it will still call .commit because
>> nothing has updated or changed its return code.
>>
>> The reason why this does not cause problems currently is because
>> backup's implementation of .commit checks for cancellation itself.
>>
>> I'd like to simplify this contract:
>>
>> (1) Abort is called if the job/transaction fails
>> (2) Commit is called if the job/transaction succeeds
>>
>> To this end: A job's return code, if 0, will be forcibly set as
>> -ECANCELED if that job has already concluded. Remove the now
>> redundant check in the backup job implementation.
>>
>> We need to check for cancellation in both block_job_completed
>> AND block_job_completed_single, because jobs may be cancelled between
>> those two calls; for instance in transactions.
>>
>> The check in block_job_completed could be removed, but there's no
>> point in starting to attempt to succeed a transaction that we know
>> in advance will fail.
>>
>> This does NOT affect mirror jobs that are "canceled" during their
>> synchronous phase. The mirror job itself forcibly sets the canceled
>> property to false prior to ceding control, so such cases will invoke
>> the "commit" callback.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 block/backup.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 block/trace-events |=C2=A0 1 +
>> =C2=A0 blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19=
 +++++++++++++++----
>> =C2=A0 3 files changed, 17 insertions(+), 5 deletions(-)
>=20
> More lines of code, but the contract does seem simpler and useful for
> the later patches.
>=20

Unfortunately yes, but it would be less overall if more than Backup made
use of commit/abort, which I anticipate in the future when I try to
start switching jobs over to using the .prepare callback.

It was just genuinely shocking to me that we'd call commit(), but backup
secretly knew we wanted abort. That type of logic belongs in the core
dispatch layer.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks for the reviews!
