Received: from eggs.gnu.org ([2001:4830:134:3::10]:47302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fC6Yu-0004J6-Ao
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fC6Yq-0005LC-9z
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:49:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fC6Yq-0005Kl-2W
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:49:28 -0400
Date: Fri, 27 Apr 2018 17:49:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180427164914.GM2608@work-vm>
References: <20180420175721.18479-1-dgilbert@redhat.com>
	<20180426050959.GN9036@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426050959.GN9036@xz-mi>
Subject: Re: [Qemu-devel] [PATCH] migration: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peter.maydell@linaro.org

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Apr 20, 2018 at 06:57:21PM +0100, Dr. David Alan Gilbert (git) wrote:
> 
> [...]
> 
> >  Saving the state of one device
> >  ==============================
> >  
> > -The state of a device is saved using intermediate buffers.  There are
> > -some helper functions to assist this saving.
> > -
> > -There is a new concept that we have to explain here: device state
> > -version.  When we migrate a device, we save/load the state as a series
> > -of fields.  Some times, due to bugs or new functionality, we need to
> > -change the state to store more/different information.  We use the
> > -version to identify each time that we do a change.  Each version is
> > -associated with a series of fields saved.  The `save_state` always saves
> > -the state as the newer version.  But `load_state` sometimes is able to
> > -load state from an older version.
> > -
> > -Legacy way
> > -----------
> > -
> > -This way is going to disappear as soon as all current users are ported to VMSTATE.
> > -
> > -Each device has to register two functions, one to save the state and
> > -another to load the state back.
> > -
> > -.. code:: c
> > -
> > -  int register_savevm(DeviceState *dev,
> > -                      const char *idstr,
> > -                      int instance_id,
> > -                      int version_id,
> > -                      SaveStateHandler *save_state,
> > -                      LoadStateHandler *load_state,
> > -                      void *opaque);
> > -
> > -  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
> > -  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
> > -
> > -The important functions for the device state format are the `save_state`
> > -and `load_state`.  Notice that `load_state` receives a version_id
> > -parameter to know what state format is receiving.  `save_state` doesn't
> > -have a version_id parameter because it always uses the latest version.
> > +For most devices, the state is saved in a single call to the migration
> > +infrastrucutre; these are *non-iterative* devices.  The data for these
> > +devices is sent at the end of precopy migration, when the CPUs are paused.
> 
> > +Where the data associated with the device is very large (e.g. RAM or large tables)
> > +see the iterative device section below.
> 
> I would prefer:
> 
>   There are also devices called *iterative* devices, which contain a
>   huge amount of data as device states (e.g., RAM or large tables).
>   Please refer to the iterative device section below for more information.

OK, I've gone with:
There are also *iterative* devices, which contain a very large amount of
data (e.g. RAM or large tables).  See the iterative device section below.

> > +
> > +General advice for device developers
> > +------------------------------------
> > +
> > +- The migration state saved should reflect the device being modelled rather
> > +  than the way your implementation works.   That way if you change the implementation
> > +  later the migration stream will stay compatible.  That model may include
> > +  internal state that's not directly visible in a register.
> > +
> > +- When saving a migration stream the device code may walk and check
> > +  the state of the device.  These checks might fail in various ways (e.g.
> > +  discovering internal state is corrupt or that the guest has done something bad).
> > +  Consider carefully before asserting/aborting at this point, since the
> > +  normal response from users is that *migration broke their VM* since it had
> > +  apparently been running fine until then.
> 
> Maybe we can give some further suggestions?
> 
>   Instead of aborting the whole VM, we can dump some error messages
>   when necessary for further diagnose. Or, we can set the device into
>   error state (or even disable the device) where capable so that at
>   least other part of the VM won't be affected, then the guest OS can
>   decide what to do next with that.

I've put:
  In these error cases, the device
  should log a message indicating the cause of error, and should consider
  putting the device into an error state, allowing the rest of the VM to
  continue execution.


> > +
> > +- The migration might happen at an inconvenient point,
> > +  e.g. right in the middle of the guest reprogramming the device, during
> > +  guest reboot or shutdown or while the device is waiting for external IO.
> > +  It's strongly preferred that migrations do not fail in this situation,
> > +  since in the cloud environment migrations might happen automatically to
> > +  VMs that the administrator doesn't directly control.
> > +
> > +- If you do need to fail a migration, ensure that sufficient information
> > +  is logged to identify what went wrong.
> > +
> > +- The destination should treat an incoming migration stream as hostile
> > +  (which we do to varying degrees in the existing code).  Check that offsets
> > +  into buffers and the like can't cause overruns.  Fail the incoming migration
> > +  in the case of a corrupted stream like this.
> > +
> > +- Take care with internal device state or behaviour that might become
> > +  migration version dependent.  For example, the order of PCI capabilities
> > +  is required to stay constant across migration.  Another example would
> > +  be that a special case handled by subsections (see below) might become
> > +  much more common if a default behaviour is changed.
> > +
> > +- Migrations timing out or being failed by higher levels of management,
> > +  or failures of the destination host are not unusual, and care should
> > +  be taken to ensure that the source VM can be restarted up until the point
> > +  when the destination starts runing.  Valid examples include the management
> > +  layer reverting the migration even though the QEMU level of migration has
> > +  succeeded.  For this reason, the state on the source VM should not be
> > +  destroyed during the migration process in normal use.
> 
> I would prefer we have a summary at the start, or just move the last
> sentence there.  Otherwise it'll be hard for quick readers to catch
> the point:
> 
>   Device states should still be kept even after a savevm operation.
>   The reason is that ...

Good point:
- The state of the source should not be changed or destroyed by the
  outgoing migration.  Migrations timing out or being failed by
  higher levels of management, or failures of the destination host are
  not unusual, and in that case the VM is restarted on the source.
  Note that the management layer can validly revert the migration
  even though the QEMU level of migration has succeeded as long as it
  does it before starting execution on the destination.


> All comments are subjective and optional, so please choose either way
> you would prefer.  The rest looks quite good to me.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks.

Dave

> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
